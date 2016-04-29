module tb_key_expander();

wire [127:0] key_out;
reg  [127:0] key_in, key_golden;

wire [31:0] sbox_in, sbox_out;

reg [4:0] round;
reg enc_dec;


key_expander KEY_EXPANDER
(
	.key_out ( key_out ),
	.g_in		 ( sbox_in ),
	.g_out   ( sbox_out),
	.key_in  ( key_in  ),
	.round   ( round[3:0]),
	.add_w_out(1'b0),
	.enc_dec ( enc_dec)
);

sBox32 SBOX32
  (
    .sbox_out_enc ( sbox_out ),
		.sbox_out_dec (),
    .sbox_in      ( sbox_in  ),
    .enc_dec      ( 1'b1  )
  );


initial
	begin
		enc_dec = 1;
		//key_in = {32'h3c_4f_cf_09, 32'h88_15_f7_ab, 32'ha6_d2_ae_28, 32'h16_15_7e_2b};
		key_golden = {32'h2b_7e_15_16, 32'h28_ae_d2_a6, 32'hab_f7_15_88, 32'h09_cf_4f_3c};
		key_in = key_golden;
		for(round = 0; round < 10; round = round + 1)
			begin
				#5;
				key_in[32*(3 + 1) - 1 : 32*3] = key_out[32*(3 + 1) - 1 : 32*3];
				#5;
				key_in[32*(2 + 1) - 1 : 32*2] = key_out[32*(2 + 1) - 1 : 32*2];
				#5;
				key_in[32*(1 + 1) - 1 : 32*1] = key_out[32*(1 + 1) - 1 : 32*1];
				#5;
				key_in[32*(0 + 1) - 1 : 32*0] = key_out[32*(0 + 1) - 1 : 32*0];
			end
		enc_dec = 0;
	for(round = 0; round < 10; round = round + 1)
			begin
				#5;
				key_in[32*(0 + 1) - 1 : 32*0] = key_out[32*(0 + 1) - 1 : 32*0];
        #5;
				key_in[32*(1 + 1) - 1 : 32*1] = key_out[32*(1 + 1) - 1 : 32*1];
				#5;
				key_in[32*(2 + 1) - 1 : 32*2] = key_out[32*(2 + 1) - 1 : 32*2];
				#5;
				key_in[32*(3 + 1) - 1 : 32*3] = key_out[32*(3 + 1) - 1 : 32*3];				
			end
			#5
				if(key_in !== key_golden)
					begin
						$display("TEST FAILL!!");
						$stop;
					end
			//for(round = 0; round < 9; round = round + 1)
			//	begin
			//		#5
			//		key_in = key_out;
			//	end
			//	#5
			//	if(key_out !== key_golden)
			//		begin
			//			$display("TEST FAILL!!");
			//			$stop;
			//		end
				$display("TEST PASSED!!!");
				$stop;
	end

endmodule

module sBox_8_lut
(
  //OUTPUTS
  output reg [7:0] sbox_out_enc, // Direct sbox_out_enc
	output [7:0] sbox_out_dec, // Inverse sbox_out_enc
  //INPUTS
  input  [7:0] sbox_in,
	input enc_dec
);
 
always @(*)
	begin
		case (sbox_in)
			8'h0 : sbox_out_enc = 8'h63;
			8'h1 : sbox_out_enc = 8'h7C;
			8'h2 : sbox_out_enc = 8'h77;
			8'h3 : sbox_out_enc = 8'h7B;
			8'h4 : sbox_out_enc = 8'hF2;
			8'h5 : sbox_out_enc = 8'h6B;
			8'h6 : sbox_out_enc = 8'h6F;
			8'h7 : sbox_out_enc = 8'hC5;
			8'h8 : sbox_out_enc = 8'h30;
			8'h9 : sbox_out_enc = 8'h1;
			8'hA : sbox_out_enc = 8'h67;
			8'hB : sbox_out_enc = 8'h2B;
			8'hC : sbox_out_enc = 8'hFE;
			8'hD : sbox_out_enc = 8'hD7;
			8'hE : sbox_out_enc = 8'hAB;
			8'hF : sbox_out_enc = 8'h76;
			8'h10 : sbox_out_enc = 8'hCA;
			8'h11 : sbox_out_enc = 8'h82;
			8'h12 : sbox_out_enc = 8'hC9;
			8'h13 : sbox_out_enc = 8'h7D;
			8'h14 : sbox_out_enc = 8'hFA;
			8'h15 : sbox_out_enc = 8'h59;
			8'h16 : sbox_out_enc = 8'h47;
			8'h17 : sbox_out_enc = 8'hF0;
			8'h18 : sbox_out_enc = 8'hAD;
			8'h19 : sbox_out_enc = 8'hD4;
			8'h1A : sbox_out_enc = 8'hA2;
			8'h1B : sbox_out_enc = 8'hAF;
			8'h1C : sbox_out_enc = 8'h9C;
			8'h1D : sbox_out_enc = 8'hA4;
			8'h1E : sbox_out_enc = 8'h72;
			8'h1F : sbox_out_enc = 8'hC0;
			8'h20 : sbox_out_enc = 8'hB7;
			8'h21 : sbox_out_enc = 8'hFD;
			8'h22 : sbox_out_enc = 8'h93;
			8'h23 : sbox_out_enc = 8'h26;
			8'h24 : sbox_out_enc = 8'h36;
			8'h25 : sbox_out_enc = 8'h3F;
			8'h26 : sbox_out_enc = 8'hF7;
			8'h27 : sbox_out_enc = 8'hCC;
			8'h28 : sbox_out_enc = 8'h34;
			8'h29 : sbox_out_enc = 8'hA5;
			8'h2A : sbox_out_enc = 8'hE5;
			8'h2B : sbox_out_enc = 8'hF1;
			8'h2C : sbox_out_enc = 8'h71;
			8'h2D : sbox_out_enc = 8'hD8;
			8'h2E : sbox_out_enc = 8'h31;
			8'h2F : sbox_out_enc = 8'h15;
			8'h30 : sbox_out_enc = 8'h4;
			8'h31 : sbox_out_enc = 8'hC7;
			8'h32 : sbox_out_enc = 8'h23;
			8'h33 : sbox_out_enc = 8'hC3;
			8'h34 : sbox_out_enc = 8'h18;
			8'h35 : sbox_out_enc = 8'h96;
			8'h36 : sbox_out_enc = 8'h5;
			8'h37 : sbox_out_enc = 8'h9A;
			8'h38 : sbox_out_enc = 8'h7;
			8'h39 : sbox_out_enc = 8'h12;
			8'h3A : sbox_out_enc = 8'h80;
			8'h3B : sbox_out_enc = 8'hE2;
			8'h3C : sbox_out_enc = 8'hEB;
			8'h3D : sbox_out_enc = 8'h27;
			8'h3E : sbox_out_enc = 8'hB2;
			8'h3F : sbox_out_enc = 8'h75;
			8'h40 : sbox_out_enc = 8'h9;
			8'h41 : sbox_out_enc = 8'h83;
			8'h42 : sbox_out_enc = 8'h2C;
			8'h43 : sbox_out_enc = 8'h1A;
			8'h44 : sbox_out_enc = 8'h1B;
			8'h45 : sbox_out_enc = 8'h6E;
			8'h46 : sbox_out_enc = 8'h5A;
			8'h47 : sbox_out_enc = 8'hA0;
			8'h48 : sbox_out_enc = 8'h52;
			8'h49 : sbox_out_enc = 8'h3B;
			8'h4A : sbox_out_enc = 8'hD6;
			8'h4B : sbox_out_enc = 8'hB3;
			8'h4C : sbox_out_enc = 8'h29;
			8'h4D : sbox_out_enc = 8'hE3;
			8'h4E : sbox_out_enc = 8'h2F;
			8'h4F : sbox_out_enc = 8'h84;
			8'h50 : sbox_out_enc = 8'h53;
			8'h51 : sbox_out_enc = 8'hD1;
			8'h52 : sbox_out_enc = 8'h0;
			8'h53 : sbox_out_enc = 8'hED;
			8'h54 : sbox_out_enc = 8'h20;
			8'h55 : sbox_out_enc = 8'hFC;
			8'h56 : sbox_out_enc = 8'hB1;
			8'h57 : sbox_out_enc = 8'h5B;
			8'h58 : sbox_out_enc = 8'h6A;
			8'h59 : sbox_out_enc = 8'hCB;
			8'h5A : sbox_out_enc = 8'hBE;
			8'h5B : sbox_out_enc = 8'h39;
			8'h5C : sbox_out_enc = 8'h4A;
			8'h5D : sbox_out_enc = 8'h4C;
			8'h5E : sbox_out_enc = 8'h58;
			8'h5F : sbox_out_enc = 8'hCF;
			8'h60 : sbox_out_enc = 8'hD0;
			8'h61 : sbox_out_enc = 8'hEF;
			8'h62 : sbox_out_enc = 8'hAA;
			8'h63 : sbox_out_enc = 8'hFB;
			8'h64 : sbox_out_enc = 8'h43;
			8'h65 : sbox_out_enc = 8'h4D;
			8'h66 : sbox_out_enc = 8'h33;
			8'h67 : sbox_out_enc = 8'h85;
			8'h68 : sbox_out_enc = 8'h45;
			8'h69 : sbox_out_enc = 8'hF9;
			8'h6A : sbox_out_enc = 8'h2;
			8'h6B : sbox_out_enc = 8'h7F;
			8'h6C : sbox_out_enc = 8'h50;
			8'h6D : sbox_out_enc = 8'h3C;
			8'h6E : sbox_out_enc = 8'h9F;
			8'h6F : sbox_out_enc = 8'hA8;
			8'h70 : sbox_out_enc = 8'h51;
			8'h71 : sbox_out_enc = 8'hA3;
			8'h72 : sbox_out_enc = 8'h40;
			8'h73 : sbox_out_enc = 8'h8F;
			8'h74 : sbox_out_enc = 8'h92;
			8'h75 : sbox_out_enc = 8'h9D;
			8'h76 : sbox_out_enc = 8'h38;
			8'h77 : sbox_out_enc = 8'hF5;
			8'h78 : sbox_out_enc = 8'hBC;
			8'h79 : sbox_out_enc = 8'hB6;
			8'h7A : sbox_out_enc = 8'hDA;
			8'h7B : sbox_out_enc = 8'h21;
			8'h7C : sbox_out_enc = 8'h10;
			8'h7D : sbox_out_enc = 8'hFF;
			8'h7E : sbox_out_enc = 8'hF3;
			8'h7F : sbox_out_enc = 8'hD2;
			8'h80 : sbox_out_enc = 8'hCD;
			8'h81 : sbox_out_enc = 8'hC;
			8'h82 : sbox_out_enc = 8'h13;
			8'h83 : sbox_out_enc = 8'hEC;
			8'h84 : sbox_out_enc = 8'h5F;
			8'h85 : sbox_out_enc = 8'h97;
			8'h86 : sbox_out_enc = 8'h44;
			8'h87 : sbox_out_enc = 8'h17;
			8'h88 : sbox_out_enc = 8'hC4;
			8'h89 : sbox_out_enc = 8'hA7;
			8'h8A : sbox_out_enc = 8'h7E;
			8'h8B : sbox_out_enc = 8'h3D;
			8'h8C : sbox_out_enc = 8'h64;
			8'h8D : sbox_out_enc = 8'h5D;
			8'h8E : sbox_out_enc = 8'h19;
			8'h8F : sbox_out_enc = 8'h73;
			8'h90 : sbox_out_enc = 8'h60;
			8'h91 : sbox_out_enc = 8'h81;
			8'h92 : sbox_out_enc = 8'h4F;
			8'h93 : sbox_out_enc = 8'hDC;
			8'h94 : sbox_out_enc = 8'h22;
			8'h95 : sbox_out_enc = 8'h2A;
			8'h96 : sbox_out_enc = 8'h90;
			8'h97 : sbox_out_enc = 8'h88;
			8'h98 : sbox_out_enc = 8'h46;
			8'h99 : sbox_out_enc = 8'hEE;
			8'h9A : sbox_out_enc = 8'hB8;
			8'h9B : sbox_out_enc = 8'h14;
			8'h9C : sbox_out_enc = 8'hDE;
			8'h9D : sbox_out_enc = 8'h5E;
			8'h9E : sbox_out_enc = 8'hB;
			8'h9F : sbox_out_enc = 8'hDB;
			8'hA0 : sbox_out_enc = 8'hE0;
			8'hA1 : sbox_out_enc = 8'h32;
			8'hA2 : sbox_out_enc = 8'h3A;
			8'hA3 : sbox_out_enc = 8'hA;
			8'hA4 : sbox_out_enc = 8'h49;
			8'hA5 : sbox_out_enc = 8'h6;
			8'hA6 : sbox_out_enc = 8'h24;
			8'hA7 : sbox_out_enc = 8'h5C;
			8'hA8 : sbox_out_enc = 8'hC2;
			8'hA9 : sbox_out_enc = 8'hD3;
			8'hAA : sbox_out_enc = 8'hAC;
			8'hAB : sbox_out_enc = 8'h62;
			8'hAC : sbox_out_enc = 8'h91;
			8'hAD : sbox_out_enc = 8'h95;
			8'hAE : sbox_out_enc = 8'hE4;
			8'hAF : sbox_out_enc = 8'h79;
			8'hB0 : sbox_out_enc = 8'hE7;
			8'hB1 : sbox_out_enc = 8'hC8;
			8'hB2 : sbox_out_enc = 8'h37;
			8'hB3 : sbox_out_enc = 8'h6D;
			8'hB4 : sbox_out_enc = 8'h8D;
			8'hB5 : sbox_out_enc = 8'hD5;
			8'hB6 : sbox_out_enc = 8'h4E;
			8'hB7 : sbox_out_enc = 8'hA9;
			8'hB8 : sbox_out_enc = 8'h6C;
			8'hB9 : sbox_out_enc = 8'h56;
			8'hBA : sbox_out_enc = 8'hF4;
			8'hBB : sbox_out_enc = 8'hEA;
			8'hBC : sbox_out_enc = 8'h65;
			8'hBD : sbox_out_enc = 8'h7A;
			8'hBE : sbox_out_enc = 8'hAE;
			8'hBF : sbox_out_enc = 8'h8;
			8'hC0 : sbox_out_enc = 8'hBA;
			8'hC1 : sbox_out_enc = 8'h78;
			8'hC2 : sbox_out_enc = 8'h25;
			8'hC3 : sbox_out_enc = 8'h2E;
			8'hC4 : sbox_out_enc = 8'h1C;
			8'hC5 : sbox_out_enc = 8'hA6;
			8'hC6 : sbox_out_enc = 8'hB4;
			8'hC7 : sbox_out_enc = 8'hC6;
			8'hC8 : sbox_out_enc = 8'hE8;
			8'hC9 : sbox_out_enc = 8'hDD;
			8'hCA : sbox_out_enc = 8'h74;
			8'hCB : sbox_out_enc = 8'h1F;
			8'hCC : sbox_out_enc = 8'h4B;
			8'hCD : sbox_out_enc = 8'hBD;
			8'hCE : sbox_out_enc = 8'h8B;
			8'hCF : sbox_out_enc = 8'h8A;
			8'hD0 : sbox_out_enc = 8'h70;
			8'hD1 : sbox_out_enc = 8'h3E;
			8'hD2 : sbox_out_enc = 8'hB5;
			8'hD3 : sbox_out_enc = 8'h66;
			8'hD4 : sbox_out_enc = 8'h48;
			8'hD5 : sbox_out_enc = 8'h3;
			8'hD6 : sbox_out_enc = 8'hF6;
			8'hD7 : sbox_out_enc = 8'hE;
			8'hD8 : sbox_out_enc = 8'h61;
			8'hD9 : sbox_out_enc = 8'h35;
			8'hDA : sbox_out_enc = 8'h57;
			8'hDB : sbox_out_enc = 8'hB9;
			8'hDC : sbox_out_enc = 8'h86;
			8'hDD : sbox_out_enc = 8'hC1;
			8'hDE : sbox_out_enc = 8'h1D;
			8'hDF : sbox_out_enc = 8'h9E;
			8'hE0 : sbox_out_enc = 8'hE1;
			8'hE1 : sbox_out_enc = 8'hF8;
			8'hE2 : sbox_out_enc = 8'h98;
			8'hE3 : sbox_out_enc = 8'h11;
			8'hE4 : sbox_out_enc = 8'h69;
			8'hE5 : sbox_out_enc = 8'hD9;
			8'hE6 : sbox_out_enc = 8'h8E;
			8'hE7 : sbox_out_enc = 8'h94;
			8'hE8 : sbox_out_enc = 8'h9B;
			8'hE9 : sbox_out_enc = 8'h1E;
			8'hEA : sbox_out_enc = 8'h87;
			8'hEB : sbox_out_enc = 8'hE9;
			8'hEC : sbox_out_enc = 8'hCE;
			8'hED : sbox_out_enc = 8'h55;
			8'hEE : sbox_out_enc = 8'h28;
			8'hEF : sbox_out_enc = 8'hDF;
			8'hF0 : sbox_out_enc = 8'h8C;
			8'hF1 : sbox_out_enc = 8'hA1;
			8'hF2 : sbox_out_enc = 8'h89;
			8'hF3 : sbox_out_enc = 8'hD;
			8'hF4 : sbox_out_enc = 8'hBF;
			8'hF5 : sbox_out_enc = 8'hE6;
			8'hF6 : sbox_out_enc = 8'h42;
			8'hF7 : sbox_out_enc = 8'h68;
			8'hF8 : sbox_out_enc = 8'h41;
			8'hF9 : sbox_out_enc = 8'h99;
			8'hFA : sbox_out_enc = 8'h2D;
			8'hFB : sbox_out_enc = 8'hF;
			8'hFC : sbox_out_enc = 8'hB0;
			8'hFD : sbox_out_enc = 8'h54;
			8'hFE : sbox_out_enc = 8'hBB;
			8'hFF : sbox_out_enc = 8'h16;
			default : sbox_out_enc = 8'h0;
		endcase
	end
endmodule

module sBox32
#(
  parameter SBOX_NUM = 4
)(
  //OUTPUTS
  output [8*SBOX_NUM - 1:0] sbox_out_enc,
  output [8*SBOX_NUM - 1:0] sbox_out_dec,
	//INPUTS
  input  [8*SBOX_NUM - 1:0] sbox_in,
	input enc_dec
);
  sBox_8_lut SBOX[SBOX_NUM - 1:0]
  (
    .sbox_out_enc ( sbox_out_enc ),
		.sbox_out_dec ( sbox_out_dec ),
    .sbox_in      ( sbox_in      ),
		.enc_dec      ( enc_dec      )
  );
  
endmodule
