`define DATAPATH AES_CORE.AES_CORE_DATAPATH
module tb_aes_core();
	
reg [31:0] bus_in;
reg [ 3:0] iv_en;
reg [ 3:0] key_en;
reg [ 1:0] data_type;
reg [ 1:0] addr;
reg [ 1:0] op_mode;
reg [ 1:0] aes_mode;
reg start;
reg write_en;
reg first_block;
//reg enc_dec;
reg rst_n;
reg clk;

reg [127:0] data_in;
reg [127:0] key_in;
reg [127:0] iv_in;

reg [127:0] golden_col, col;
//=============================================================================
// Operation Modes
//=============================================================================
localparam ENCRYPTION     = 2'b00;
localparam KEY_DERIVATION = 2'b01;
localparam DECRYPTION     = 2'b10;
localparam DECRYP_W_DERIV = 2'b11;

//=============================================================================
// AES Modes
//=============================================================================
localparam ECB = 2'b00;
localparam CBC = 2'b01;
localparam CTR = 2'b10;

aes_core AES_CORE
(
	.bus_in      ( bus_in      ),
	.iv_en       ( iv_en       ),
	.key_en      ( key_en      ),
	.data_type   ( data_type   ),
	.addr        ( addr        ),
	.op_mode     ( op_mode     ),
	.aes_mode    ( aes_mode    ),
	.start       ( start       ),
	.write_en    ( write_en    ),
	.first_block ( first_block ),
	//.enc_dec     ( enc_dec     ),
	.rst_n       ( rst_n       ),
	.clk         ( clk         )
);


task reset;
	begin
		clk = 0;
		iv_en = 4'b0000;
		key_en = 4'b0000;
		data_type = 2'b00;
		addr = 4'b0000;
		op_mode = ENCRYPTION;
		aes_mode = ECB;
		start = 0;
		write_en = 0;
		first_block = 0;
		//enc_dec = 1;
		rst_n = 0;
		@(posedge clk);
		rst_n = 1;
	end
endtask

task write_col;
	input [127:0] data_in;
	begin
		@(negedge clk);
		addr = 0;
		write_en = 1;
		bus_in = data_in[127:96];
		@(negedge clk);
		addr = 1;
		bus_in = data_in[95:64];
		@(negedge clk);
		addr = 2;
		bus_in = data_in[63:32];
		@(negedge clk);
		addr = 3;
		bus_in = data_in[31:0];
		@(negedge clk)
		write_en = 0;
		addr = 0;
	end
endtask

task write_key;
	input [127:0] data_in;
	begin
		@(negedge clk);
		key_en = 4'b0001;
		bus_in = data_in[127:96];
		@(negedge clk);
		key_en = 4'b0010;
		bus_in = data_in[95:64];
		@(negedge clk);
		key_en = 4'b0100;
		bus_in = data_in[63:32];
		@(negedge clk);
		key_en = 4'b1000;
		bus_in = data_in[31:0];
		@(negedge clk)
		key_en = 4'b0000;
	end
endtask

task write_iv;
	input [127:0] data_in;
	begin
		@(negedge clk);
		iv_en = 4'b0001;
		bus_in = data_in[127:96];
		@(negedge clk);
		iv_en = 4'b0010;
		bus_in = data_in[95:64];
		@(negedge clk);
		iv_en = 4'b0100;
		bus_in = data_in[63:32];
		@(negedge clk);
		iv_en = 4'b1000;
		bus_in = data_in[31:0];
		@(negedge clk)
		iv_en = 4'b0000;
	end
endtask

initial
	begin
		reset;
		data_in = 128'h00112233445566778899aabbccddeeff;
		key_in  = 128'h000102030405060708090a0b0c0d0e0f;
		write_col(data_in);
		write_key(key_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end

		data_in = 128'h3243f6a8885a308d313198a2e0370734;
		key_in  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		write_col(data_in);
		write_key(key_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h3925841d02dc09fbdc118597196a0b32;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end
		
		op_mode = KEY_DERIVATION;
		key_in  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		write_key(key_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'hd014f9a8c9ee2589e13f0cc8b6630ca6;
		col = {`DATAPATH.key[0], `DATAPATH.key[1], `DATAPATH.key[2], `DATAPATH.key[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end

		op_mode = DECRYPTION;	
		data_in = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
		key_in  = 128'h13111d7fe3944a17f307a78b4d2b30c5;
		write_col(data_in);
		write_key(key_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h00112233445566778899aabbccddeeff;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end

		op_mode = DECRYP_W_DERIV;
		data_in = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
		key_in  = 128'h000102030405060708090a0b0c0d0e0f;
		write_col(data_in);
		write_key(key_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h00112233445566778899aabbccddeeff;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end

		op_mode = KEY_DERIVATION;
		key_in  = 128'h000102030405060708090a0b0c0d0e0f;
		write_key(key_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		op_mode = DECRYPTION;
		data_in = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h00112233445566778899aabbccddeeff;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end
		$display("ECB TEST\nTEST PASSED!!!");

		// CBC Encryption
		aes_mode = CBC;
		op_mode = ENCRYPTION;
		key_in  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		iv_in   = 128'h000102030405060708090a0b0c0d0e0f;
		//BLOCK 1
		data_in = 128'h6bc1bee22e409f96e93d7e117393172a;
		first_block = 1; 
		write_key(key_in);
		write_iv(iv_in);
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h7649abac8119b246cee98e9b12e9197d;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end

		//BLOCK 2
		first_block = 0;
		data_in = 128'hae2d8a571e03ac9c9eb76fac45af8e51;
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h5086cb9b507219ee95db113a917678b2;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILDES!!!");
				$stop;
			end

		//BLOCK 3
		data_in = 128'h30c81c46a35ce411e5fbc1191a0a52ef;
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h73bed6b8e3c1743b7116e69e22229516;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILDES!!!");
				$stop;
			end

		//BLOCK 4
		data_in = 128'hf69f2445df4f9b17ad2b417be66c3710;
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h3ff1caa1681fac09120eca307586e1a7 ;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILDES!!!");
				$stop;
			end
		$display("CBC ENCRYPTION\nTEST PASSED!!!");

		// CBC Decryption
		op_mode = DECRYP_W_DERIV;
		key_in  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		iv_in   = 128'h000102030405060708090a0b0c0d0e0f;
		//BLOCK 1
		data_in = 128'h7649abac8119b246cee98e9b12e9197d;
		first_block = 1; 
		write_key(key_in);
		write_iv(iv_in);
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h6bc1bee22e409f96e93d7e117393172a;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end

		//BLOCK 2
		data_in = 128'h5086cb9b507219ee95db113a917678b2;
		first_block = 0; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'hae2d8a571e03ac9c9eb76fac45af8e51 ;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end

		//BLOCK 3
		data_in = 128'h73bed6b8e3c1743b7116e69e22229516; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h30c81c46a35ce411e5fbc1191a0a52ef ;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end

		//BLOCK 4
		data_in = 128'h3ff1caa1681fac09120eca307586e1a7; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'hf69f2445df4f9b17ad2b417be66c3710 ;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end
		$display("CBC DECRYPTION\nTEST PASSED!!!");

//CTR ENCRYPTION
		aes_mode = CTR;
		op_mode = ENCRYPTION;
		key_in  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		iv_in   = 128'hf0f1f2f3f4f5f6f7f8f9fafbfcfdfeff;
		//BLOCK 1
		data_in = 128'h6bc1bee22e409f96e93d7e117393172a;
		first_block = 1; 
		write_key(key_in);
		write_iv(iv_in);
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h874d6191b620e3261bef6864990db6ce ;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end
		
		//BLOCK 2
		data_in = 128'hae2d8a571e03ac9c9eb76fac45af8e51;
		first_block = 0; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h9806f66b7970fdff8617187bb9fffdff;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end
		
		//BLOCK 3
		data_in = 128'h30c81c46a35ce411e5fbc1191a0a52ef; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h5ae4df3edbd5d35e5b4f09020db03eab;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end
		
		//BLOCK 4
		data_in = 128'hf69f2445df4f9b17ad2b417be66c3710; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h1e031dda2fbe03d1792170a0f3009cee ;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end
		$display("CTR ENCRYPTION\nTEST PASSED!!!");

//CTR DECRYPTION
		aes_mode = CTR;
		op_mode = DECRYPTION;
		key_in  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		iv_in   = 128'hf0f1f2f3f4f5f6f7f8f9fafbfcfdfeff;
		//BLOCK 1
		data_in = 128'h874d6191b620e3261bef6864990db6ce;
		first_block = 1; 
		write_key(key_in);
		write_iv(iv_in);
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h6bc1bee22e409f96e93d7e117393172a;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILLED!!!");
				$stop;
			end

		//BLOCK 2
		data_in = 128'h9806f66b7970fdff8617187bb9fffdff;
		first_block = 0; 
		op_mode = DECRYP_W_DERIV; //Esas configuracoes nao importam em modo CTR - testando isso ;)
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'hae2d8a571e03ac9c9eb76fac45af8e51;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end

		//BLOCK 3
		data_in = 128'h5ae4df3edbd5d35e5b4f09020db03eab;
		first_block = 1; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'h30c81c46a35ce411e5fbc1191a0a52ef;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end

		//BLOCK 4
		data_in = 128'h1e031dda2fbe03d1792170a0f3009cee;
		first_block = 0; 
		write_col(data_in);
		start = 1;
		@(posedge clk);
		start = 0;
		@(posedge AES_CORE.AES_CORE_CONTROL_UNIT.state == 0);
		@(posedge clk);
		@(posedge clk);
		golden_col = 128'hf69f2445df4f9b17ad2b417be66c3710;
		col = {`DATAPATH.col[0], `DATAPATH.col[1], `DATAPATH.col[2], `DATAPATH.col[3]};
		if(col != golden_col)
			begin
				$display("TEST FAILL!!!");
				$stop;
			end
		$display("CTR TEST\nTEST PASSED!!!");
		$stop;
	end

always #10
	clk = !clk;

endmodule
