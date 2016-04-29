module datapath
(
	// OUTPUTS
	output [31:0] col_bus,
	output [31:0] key_bus,
	output [31:0] iv_bus,
	output end_aes,
    output [31:0] key_host_0_wr,
    output [31:0] key_host_1_wr,
    output [31:0] key_host_2_wr,
    output [31:0] key_host_3_wr,
    output key_host_0_ren,
    output key_host_1_ren,
    output key_host_2_ren,
    output key_host_3_ren,
    output key_host_0_wen,
    output key_host_1_wen,
    output key_host_2_wen,
    output key_host_3_wen,
	// INPUTS
    input [31:0] key_host_0_rd,
    input [31:0] key_host_1_rd,
    input [31:0] key_host_2_rd,
    input [31:0] key_host_3_rd,
	input [31:0] bus_in,
	input [ 1:0] data_type,
	input [ 1:0] rk_sel,
	input [ 1:0] key_out_sel,
	input [ 3:0] round,
	input [ 2:0] sbox_sel,
	input [ 3:0] iv_en,
	input [ 3:0] iv_sel_rd,
	input [ 3:0] col_en_host,
	input [ 3:0] col_en_cnt_unit,
	input [ 3:0] key_host_en,
	input [ 3:0] key_en,
	input [ 1:0] key_sel_rd,
	input [ 1:0] col_sel,
	input [ 1:0] col_sel_host,
	input end_comp,
	input key_sel,
	input key_init,
	input bypass_rk,
	input bypass_key_en,
	input first_block,
	input last_round,
	input iv_cnt_en,
	input iv_cnt_sel,
	input enc_dec,
	input mode_ctr,
	input mode_cbc,
	input key_gen,
	input key_derivation_en,
	input rst_n,
	input clk
);

`include "control_unit_params.h"

reg [31 : 0] col     [0:3];
reg [31 : 0] key     [0:3];
reg [31 : 0] bkp     [0:3];
reg [31 : 0] bkp_1   [0:3];
reg [31 : 0] iv      [0:3];
wire[31 : 0] key_host[0:3];

reg  [127 : 0] col_in;
reg  [ 31 : 0] data_in;
reg  [ 31 : 0] add_rd_key_in;
reg  [ 31 : 0] sbox_input;
reg  [ 31 : 0] key_mux_out;
reg  [ 31 : 0] iv_mux_out;
reg  [ 31 : 0] bkp_mux_out;

wire [127 : 0] key_in, key_out;
wire [127 : 0] sr_input;
wire [127 : 0] sr_enc, sr_dec;
wire [ 31 : 0] add_rk_out;
wire [ 31 : 0] sbox_out_enc;
wire [ 31 : 0] sbox_out_dec;
wire [ 31 : 0] g_in;
wire [ 31 : 0] mix_out_enc;
wire [ 31 : 0] mix_out_dec;
wire [ 31 : 0] add_rd;
wire [ 31 : 0] bus_swap;
wire [ 31 : 0] iv_bkp_mux;
wire [ 31 : 0] xor_input_bkp_iv;
wire [ 31 : 0] sr_input_0;
wire [ 31 : 0] sr_input_3;
wire [  3 : 0] key_en_sel;
wire [  3 : 0] bkp_en;
wire [  3 : 0] col_en;
wire [  1 : 0] key_mux_sel;
wire [  1 : 0] rk_sel_mux;
wire [  1 : 0] col_sel_w_bypass;
wire [  3 : 0] col_en_w_bypass;
wire rk_out_sel;
wire add_rk_sel;
wire key_sel_mux;
wire key1_mux_cnt;
wire enc_dec_sbox;

reg [31 : 0] sbox_pp2;
reg [ 3 : 0] col_en_cnt_unit_pp1;
reg [ 3 : 0] col_en_cnt_unit_pp2;
reg [ 3 : 0] key_en_pp1;
reg [ 3 : 0] round_pp1;
reg [ 1 : 0] col_sel_pp1;
reg [ 1 : 0] col_sel_pp2;
reg [ 1 : 0] key_out_sel_pp1;
reg [ 1 : 0] key_out_sel_pp2;
reg [ 1 : 0] rk_sel_pp1;
reg [ 1 : 0] rk_sel_pp2;
reg key_sel_pp1;
reg rk_out_sel_pp1, rk_out_sel_pp2;
reg last_round_pp1, last_round_pp2;
reg end_aes_pp1, end_aes_pp2;

assign key_bus = key_mux_out;
assign iv_bus = iv_mux_out;

// Input Swap Unit
data_swap SWAP_IN
(
	.data_swap( bus_swap  ),
	.data_in  ( bus_in    ),
	.swap_type( data_type )
);

// Output Swap Unit
data_swap SWAP_OUT
(
	.data_swap( col_bus    ),
	.data_in  ( sbox_input ),
	.swap_type( data_type  )
);

// IV and BKP Muxs
always @(*)
	begin: IV_BKP_MUX
		integer i;
		iv_mux_out  = {32{1'b0}};
		bkp_mux_out = {32{1'b0}};
		for(i = 0; i < 4; i = i + 1)
			begin
				if(col_en[i] | iv_sel_rd[i])
					begin
						iv_mux_out  = iv[i];
						bkp_mux_out = bkp[i];
					end
			end
	end

assign iv_bkp_mux = (first_block && !mode_ctr) ? iv_mux_out : bkp_mux_out;

assign xor_input_bkp_iv = ((enc_dec && !mode_ctr) ? bus_swap : add_rk_out) ^ iv_bkp_mux;

always @(*)
	begin
		data_in = {32{1'b0}};
		case(1'b1)
			mode_cbc:
				data_in = (enc_dec || last_round) ? xor_input_bkp_iv : bus_swap;
			mode_ctr:
				data_in = (last_round) ? xor_input_bkp_iv : iv_mux_out;
			default:
				data_in = bus_swap;
		endcase
	end

assign bkp_en = ( {4{ mode_cbc && last_round && enc_dec}} & col_en_cnt_unit_pp2) | 
                ( {4{(mode_cbc && !enc_dec) || mode_ctr}} & col_en_host     );


// IV and BKP Registers
generate
	genvar l;
	for(l = 0; l < 4; l = l + 1)
		always @(posedge clk, negedge rst_n)
			begin
				if(!rst_n)
					begin
						iv[l]    <= {32{1'b0}};
						bkp[l]   <= {32{1'b0}};
						bkp_1[l] <= {32{1'b0}};
					end
				else
					begin
						if(l == 3)
							begin 
								if(iv_en[l] || iv_cnt_en) 
									iv[l] <= (iv_cnt_sel) ? iv[l] + 1'b1 : bus_in;
							end
						else
							begin
								if(iv_en[l]) 
									iv[l] <= bus_in;
							end

					if(bkp_en[l])
						bkp[l] <= (mode_ctr) ? bus_swap : ((mode_cbc && enc_dec) ? col_in : bkp_1[l]);

					if(bkp_en[l])
						bkp_1[l] <= col_in;
					end 
			end
endgenerate

assign col_sel_w_bypass = (bypass_rk) ? col_sel : col_sel_pp2; 

// Columns Input Multiplexors
always @(*)
	begin
		col_in = {128{1'b0}};
		case(col_sel_w_bypass)
			SHIFT_ROWS:
				col_in = (enc_dec) ? sr_enc : sr_dec;
			ADD_RK_OUT:
				col_in = {4{add_rk_out}};
			INPUT:
				col_in = {4{data_in}};	 
		endcase
	end

assign col_en_w_bypass = (bypass_rk) ? col_en_cnt_unit : col_en_cnt_unit_pp2; 
assign col_en = col_en_host | col_en_w_bypass;

// Columns Definition
generate
	genvar i;
	for(i = 0; i < 4; i = i + 1)
		always @(posedge clk, negedge rst_n)
			begin
				if(!rst_n)
					col[3 - i] <= {32{1'b0}};
				else 
				if(col_en[3 - i])
					col[3 - i] <= col_in[32*(i + 1) - 1 : 32*i]; 
			end
endgenerate

// Shift Rows Operation
assign sr_input_3 = (enc_dec) ? add_rk_out : col[3];
assign sr_input_0 = (enc_dec) ? col[0] : add_rk_out;
assign sr_input = {sr_input_0, col[1], col[2], sr_input_3};

shift_rows SHIFT_ROW
(
	.data_out_enc  ( sr_enc   ),
	.data_out_dec  ( sr_dec   ),
  .data_in       ( sr_input ) 
);

//SBOX Input Multiplexor
always @(*)
	begin
		sbox_input = {32{1'b0}};
		case(sbox_sel | col_sel_host)
			COL_0:
				sbox_input = col[0];
			COL_1:
				sbox_input = col[1];
			COL_2:
				sbox_input = col[2];
			COL_3:
				sbox_input = col[3];
			G_FUNCTION:
				sbox_input = g_in;
		endcase
	end

// 32 bits SBOX
assign enc_dec_sbox = enc_dec | key_gen;
 sBox SBOX
  (
    .sbox_out_enc ( sbox_out_enc ),
		.sbox_out_dec ( sbox_out_dec ),
    .sbox_in      ( sbox_input   ),
    .enc_dec      ( enc_dec_sbox ),
		.clk          ( clk          )
  );

// Second stage of pipeline
always @(posedge clk)
	begin
		sbox_pp2 <= (enc_dec || mode_ctr) ? sbox_out_enc : sbox_out_dec ^ key_mux_out;
	end

assign key_en_sel  = (bypass_key_en) ? key_en : key_en_pp1;
assign key_sel_mux = (bypass_key_en) ? key_sel : key_sel_pp1;
 
// Key registers
assign key_host[0] = key_host_0_rd;
assign key_host[1] = key_host_1_rd;
assign key_host[2] = key_host_2_rd;
assign key_host[3] = key_host_3_rd;
assign key_host_0_wr = (key_derivation_en) ? key[0] : bus_in;
assign key_host_1_wr = (key_derivation_en) ? key[1] : bus_in;
assign key_host_2_wr = (key_derivation_en) ? key[2] : bus_in;
assign key_host_3_wr = (key_derivation_en) ? key[3] : bus_in;
assign key_host_0_wen = (key_host_en[0] || key_derivation_en);
assign key_host_1_wen = (key_host_en[1] || key_derivation_en);
assign key_host_2_wen = (key_host_en[2] || key_derivation_en);
assign key_host_3_wen = (key_host_en[3] || key_derivation_en);
assign key_host_0_ren = (~key_host_en[0] && ~key_sel_mux);
assign key_host_1_ren = (~key_host_en[1] && ~key_sel_mux);
assign key_host_2_ren = (~key_host_en[2] && ~key_sel_mux);
assign key_host_3_ren = (~key_host_en[3] && ~key_sel_mux);
generate
	genvar j;
	for(j = 0; j < 4; j = j + 1)
		always @(posedge clk, negedge rst_n)
			begin
				if(!rst_n)
					begin
						//key_host[3 - j] <= {32{1'b0}};
						key[3 - j] <= {32{1'b0}};
					end
				else
					begin
						//if(key_host_en[3 - j] || key_derivation_en)
						//	key_host[3 - j] <= (key_derivation_en) ? key[3 - j] : bus_in;
					
						if(key_en_sel[3 - j] || key_host_en[3 - j])
							key[3 - j] <= (key_sel_mux) ? key_out[32*(j + 1) - 1 : 32*j] : ( (key_host_en[3 - j]) ? bus_in : key_host[3 - j] );
					end  
			end
endgenerate

assign key_in = {key[0], key[1], key[2], key[3]};

assign key1_mux_cnt = bypass_key_en & enc_dec;

key_expander KEY_EXPANDER
(
	.key_out   ( key_out       ),
	.g_in		   ( g_in          ),
	.g_out     ( sbox_out_enc  ),
	.key_in    ( key_in        ),
	.round     ( round_pp1     ),
	.add_w_out ( key1_mux_cnt  ),
	.enc_dec   ( enc_dec | key_gen)
);

assign key_mux_sel = (bypass_key_en) ? key_out_sel : ( (enc_dec | mode_ctr) ? key_out_sel_pp2 : key_out_sel_pp1 );

// Key Expander Mux
always @(*)
	begin
		key_mux_out = {32{1'b0}};
		case(key_mux_sel | key_sel_rd)
			KEY_0:
				key_mux_out = key[0];
			KEY_1:
				key_mux_out = key[1];
			KEY_2:
				key_mux_out = key[2];
			KEY_3:
				key_mux_out = key[3];	
		endcase
	end

  mix_columns MIX_COL
  (
    .mix_out_enc ( mix_out_enc  ),
		.mix_out_dec ( mix_out_dec  ),
    .mix_in      ( sbox_pp2     )
  );

assign rk_sel_mux = (bypass_rk) ? rk_sel : rk_sel_pp2;

always @(*)
	begin
		add_rd_key_in = {32{1'b0}};
		case(rk_sel_mux)
			COL:
				add_rd_key_in = sbox_input;
			MIXCOL_IN:
				add_rd_key_in = sbox_pp2;
			MIXCOL_OUT:
				add_rd_key_in = mix_out_enc;
		endcase
	end

// Add Round Key
assign add_rd = add_rd_key_in ^ key_mux_out;

assign rk_out_sel = (enc_dec | mode_ctr | bypass_rk);

assign add_rk_sel = (bypass_rk) ? rk_out_sel : rk_out_sel_pp2;

assign add_rk_out = (add_rk_sel) ? add_rd : (last_round_pp2 ? sbox_pp2 : mix_out_dec);

assign end_aes = end_aes_pp2;

// Pipeline Registers for Control Signals
always @(posedge clk, negedge rst_n)
	begin
		if(!rst_n)
			begin
				end_aes_pp1 <= DISABLE;
				end_aes_pp2 <= DISABLE;

				col_sel_pp1 <= INPUT; 
				col_sel_pp2 <= INPUT;

				col_en_cnt_unit_pp1 <= COL_DIS;
				col_en_cnt_unit_pp2 <= COL_DIS;

				key_sel_pp1 <= KEY_HOST;
				key_en_pp1  <= KEY_DIS;

				round_pp1 <= 4'b0000;

				key_out_sel_pp1 <= KEY_0;
				key_out_sel_pp2 <= KEY_0;

				rk_sel_pp1 <= COL;
				rk_sel_pp2 <= COL;

				rk_out_sel_pp1 <= 1'b1;
				rk_out_sel_pp2 <= 1'b1;

				last_round_pp1 <= 1'b1;
				last_round_pp2 <= 1'b0;
			end
		else
			begin
				col_sel_pp1 <= col_sel;
				col_sel_pp2 <= col_sel_pp1;

				if(!bypass_rk)
					begin	
						col_en_cnt_unit_pp1 <= col_en_cnt_unit;
						col_en_cnt_unit_pp2 <= col_en_cnt_unit_pp1;
					end

				key_sel_pp1 <= key_sel;

				if(!bypass_key_en)
					key_en_pp1 <= key_en;

				round_pp1 <= round;

				key_out_sel_pp1 <= key_out_sel;
				key_out_sel_pp2 <= key_out_sel_pp1;

				rk_sel_pp1 <= rk_sel;
				rk_sel_pp2 <= rk_sel_pp1;

				rk_out_sel_pp1 <= rk_out_sel;
				rk_out_sel_pp2 <= rk_out_sel_pp1;

				last_round_pp1 <= last_round;
				last_round_pp2 <= last_round_pp1;

				end_aes_pp1 <= end_comp;
				end_aes_pp2 <= end_aes_pp1;
			end
	end
endmodule