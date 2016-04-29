module control_unit
(
	output reg [ 2:0] sbox_sel,
	output reg [ 1:0] rk_sel,
	output reg [ 1:0] key_out_sel,
	output reg [ 1:0] col_sel,
	output reg [ 3:0] key_en,
	output reg [ 3:0] col_en,
	output     [ 3:0] round,
	output reg bypass_rk,
	output reg bypass_key_en,
	output reg key_sel,
	output reg iv_cnt_en,
	output reg iv_cnt_sel,
	output reg key_derivation_en,
	output reg end_comp,
	output key_init,
	output key_gen,
	output mode_ctr,
	output mode_cbc,
	output last_round,
  output encrypt_decrypt,	
	input [1:0] operation_mode,
	input [1:0] aes_mode,
	input start,
	input disable_core,
	input clk,
	input rst_n
);
`include "host_interface.h"
`include "control_unit_params.h"

localparam NUMBER_ROUND      = 4'd10;
localparam NUMBER_ROUND_INC  = 4'd11;
localparam INITIAL_ROUND     = 4'd00;

//=============================================================================
// FSM STATES
//=============================================================================
localparam IDLE        = 4'd00;
localparam ROUND0_COL0 = 4'd01;
localparam ROUND0_COL1 = 4'd02;
localparam ROUND0_COL2 = 4'd03;
localparam ROUND0_COL3 = 4'd04;
localparam ROUND_KEY0  = 4'd05;
localparam ROUND_COL0  = 4'd06;
localparam ROUND_COL1  = 4'd07;
localparam ROUND_COL2  = 4'd08;
localparam ROUND_COL3  = 4'd09;
localparam READY       = 4'd10;
localparam GEN_KEY0    = 4'd11;
localparam GEN_KEY1    = 4'd12;
localparam GEN_KEY2    = 4'd13;
localparam GEN_KEY3    = 4'd14;
localparam NOP         = 4'd15;

reg [3:0] state, next_state;
reg [3:0] rd_count;

reg rd_count_en;
wire op_key_derivation;
wire first_round;
wire [1:0] op_mode;

// State Flops Definition
always @(posedge clk, negedge rst_n)
	begin
		if(!rst_n)
			state <= IDLE;
		else
			if(disable_core)
				state <= IDLE;
			else
				state <= next_state;
	end

assign encrypt_decrypt = (op_mode == ENCRYPTION || op_mode == KEY_DERIVATION || 
														state == GEN_KEY0   ||   state == GEN_KEY1       ||
														state == GEN_KEY2   ||   state == GEN_KEY3       );

assign enc_dec = encrypt_decrypt | mode_ctr;
assign key_gen = (state == ROUND_KEY0);

assign op_key_derivation = (op_mode == KEY_DERIVATION);

assign mode_ctr = (aes_mode == CTR);
assign mode_cbc = (aes_mode == CBC);

assign key_init = start;

assign op_mode = (mode_ctr) ? ENCRYPTION : operation_mode;

// Next State Logic
always @(*)
	begin
		next_state = state;
		case(state)
			IDLE:
				begin
					if(!start)
						next_state = IDLE;
					else
						case(op_mode)
							ENCRYPTION    : next_state = ROUND0_COL0;
							DECRYPTION    : next_state = ROUND0_COL3;
							KEY_DERIVATION: next_state = GEN_KEY0;
							DECRYP_W_DERIV: next_state = GEN_KEY0;
							default       : next_state = IDLE;
						endcase
				end
			ROUND0_COL0:
				begin
					next_state = (enc_dec) ? ROUND0_COL1 : ROUND_KEY0; 
				end
			ROUND0_COL1:
				begin
					next_state = (enc_dec) ? ROUND0_COL2 : ROUND0_COL0;
				end
			ROUND0_COL2:
				begin
					next_state = (enc_dec) ? ROUND0_COL3 : ROUND0_COL1;
				end
			ROUND0_COL3:
				begin
					next_state = (enc_dec) ? ROUND_KEY0 : ROUND0_COL2;
				end
			ROUND_KEY0 :
				begin
					if(!first_round)
						begin
							next_state = (last_round) ? READY : NOP;
						end
					else
						begin
							next_state = (enc_dec) ? ROUND_COL0 : ROUND_COL3;
						end
				end
			NOP        :
				begin
					next_state = (enc_dec) ? ROUND_COL0 : ROUND_COL3;
				end
			ROUND_COL0 :
				begin
					next_state = (enc_dec) ? ROUND_COL1 : ROUND_KEY0;
				end
			ROUND_COL1 :
				begin
					next_state = (enc_dec) ? ROUND_COL2 : ROUND_COL0;
				end
			ROUND_COL2 :
				begin
					next_state = (enc_dec) ? ROUND_COL3 : ROUND_COL1;
				end
			ROUND_COL3 :
				begin
					if(last_round && enc_dec)
						next_state = READY;
					else
					next_state = (enc_dec) ? ROUND_KEY0 : ROUND_COL2;
				end
			GEN_KEY0   :
				begin
					next_state = GEN_KEY1;
				end
			GEN_KEY1   :
				begin
					next_state = GEN_KEY2;
				end
			GEN_KEY2   :
				begin
					next_state = GEN_KEY3;
				end
			GEN_KEY3   :
				begin
					if(last_round)
						next_state = (op_key_derivation) ? READY : ROUND0_COL3;
					else
						next_state = GEN_KEY0;
				end
			READY      :
				begin
					next_state = IDLE;
				end
		endcase
	end
 
       
// Output Logic
always @(*)
	begin
		sbox_sel = COL_0;
		rk_sel = COL;
		bypass_rk = DISABLE;
		key_out_sel = KEY_0;
		col_sel = INPUT;
		key_sel = KEY_HOST;
		key_en = KEY_DIS;
		col_en = COL_DIS;
		rd_count_en = DISABLE;
		iv_cnt_en = DISABLE;
		iv_cnt_sel = IV_BUS;
		bypass_key_en = DISABLE;
		key_derivation_en = DISABLE;
		end_comp = DISABLE;
		case(state)
			ROUND0_COL0:
				begin
					sbox_sel = COL_0;
					rk_sel   = COL;
					bypass_rk = ENABLE;
					bypass_key_en = ENABLE;
					key_out_sel = KEY_0;
					col_sel = (enc_dec) ? ADD_RK_OUT : SHIFT_ROWS;
					col_en =  (enc_dec) ? EN_COL_0 : COL_ALL;
				end
			ROUND0_COL1:
				begin
					sbox_sel = COL_1;
					rk_sel   = COL;
					bypass_rk = ENABLE;
					bypass_key_en = ENABLE;
					key_out_sel = KEY_1;
					col_sel = ADD_RK_OUT;
					col_en = EN_COL_1;
					if(!enc_dec)
						begin
							key_sel = KEY_OUT;
							key_en =  EN_KEY_1;
						end
				end
			ROUND0_COL2:
				begin
					sbox_sel = COL_2;
					rk_sel   = COL;
					bypass_rk = ENABLE;
					bypass_key_en = ENABLE;
					key_out_sel = KEY_2;
					col_sel = ADD_RK_OUT;
					col_en = EN_COL_2;
					if(!enc_dec)
						begin
							key_sel = KEY_OUT;
							key_en =  EN_KEY_2;
						end
				end
			ROUND0_COL3:
				begin
					sbox_sel = COL_3;
					rk_sel   = COL;
					bypass_key_en = ENABLE;
					key_out_sel = KEY_3;
					col_sel = (enc_dec) ? SHIFT_ROWS : ADD_RK_OUT;
					col_en =  (enc_dec) ? COL_ALL : EN_COL_3;
					bypass_rk = ENABLE;
					if(!enc_dec)
						begin
							key_sel = KEY_OUT;
							key_en =  EN_KEY_3;
						end
				end
			ROUND_KEY0:
				begin
					sbox_sel = G_FUNCTION;
					key_sel = KEY_OUT;
					key_en = EN_KEY_0;
					rd_count_en = ENABLE;
				end
			ROUND_COL0:
				begin
					sbox_sel = COL_0;
					rk_sel = (last_round) ? MIXCOL_IN : MIXCOL_OUT;
					key_out_sel = KEY_0;
					key_sel = KEY_OUT;
					if(enc_dec)
						key_en = EN_KEY_1;
					if((mode_cbc && last_round && !enc_dec) || (mode_ctr && last_round))
						col_sel = INPUT;
					else
						begin
							if(!enc_dec)
								col_sel = (last_round) ? ADD_RK_OUT : SHIFT_ROWS;
							else
								col_sel = ADD_RK_OUT;
						end
					if(enc_dec)
						col_en = EN_COL_0;
					else
						col_en = (last_round) ? EN_COL_0 : COL_ALL;
				end
			ROUND_COL1:
				begin
					sbox_sel = COL_1;
					rk_sel   = (last_round) ? MIXCOL_IN : MIXCOL_OUT;
					key_out_sel = KEY_1;
					key_sel = KEY_OUT;
					if(enc_dec)
						key_en = EN_KEY_2;
					else
						key_en = EN_KEY_1;
					if((mode_cbc && last_round && !enc_dec) || (mode_ctr && last_round))
						col_sel = INPUT;
					else
						col_sel = ADD_RK_OUT;
					col_en = EN_COL_1;
				end
			ROUND_COL2:
				begin
					sbox_sel = COL_2;
					rk_sel   = (last_round) ? MIXCOL_IN : MIXCOL_OUT;
					key_out_sel = KEY_2;
					key_sel = KEY_OUT;
					if(enc_dec)
						key_en = EN_KEY_3;
					else
						key_en = EN_KEY_2;
					if((mode_cbc && last_round && !enc_dec) || (mode_ctr && last_round))
						col_sel = INPUT;
					else
						col_sel = ADD_RK_OUT;
					col_en = EN_COL_2;
				end
			ROUND_COL3:
				begin
					sbox_sel = COL_3;
					rk_sel   = (last_round) ? MIXCOL_IN : MIXCOL_OUT;
					key_out_sel = KEY_3;
					key_sel = KEY_OUT;
					if(!enc_dec)
						key_en = EN_KEY_3;
					if((mode_cbc && last_round && !enc_dec) || (mode_ctr && last_round))
						col_sel = INPUT;
					else
						begin
							if(enc_dec)
								col_sel = (last_round) ? ADD_RK_OUT : SHIFT_ROWS;
							else
								col_sel = ADD_RK_OUT;
						end
					if(enc_dec)
						col_en = (last_round) ? EN_COL_3 : COL_ALL;
					else
						col_en = EN_COL_3;
					if(mode_ctr && last_round)
						begin
							iv_cnt_en = ENABLE;
							iv_cnt_sel = IV_CNT;
						end
				end
			GEN_KEY0:
				begin
					sbox_sel = G_FUNCTION;
					rd_count_en = ENABLE;
				end
			GEN_KEY1:
				begin
					key_en = EN_KEY_1 | EN_KEY_0; //Enable key 0 AND key 1
					key_sel = KEY_OUT;
					bypass_key_en = ENABLE;
				end
			GEN_KEY2:
				begin
					key_en = EN_KEY_2;
					key_sel = KEY_OUT;
					bypass_key_en = ENABLE;
				end
			GEN_KEY3:
				begin
					key_en = EN_KEY_3;
					key_sel = KEY_OUT;
					bypass_key_en = ENABLE;
				end
			READY:
				begin
					end_comp = ENABLE;
					if(op_mode == KEY_DERIVATION)
						key_derivation_en = ENABLE;
				end
		endcase
	end

// Round Counter
always @(posedge clk, negedge rst_n)
	begin
		if(!rst_n)
			rd_count <= INITIAL_ROUND;
		else
			if(state == IDLE || (state == GEN_KEY3 && last_round))
				rd_count <= INITIAL_ROUND;
			else 
				if(rd_count_en)
					rd_count <= rd_count + 1'b1;
	end

assign round = rd_count;
assign first_round = (rd_count == INITIAL_ROUND);
assign last_round  = (rd_count == NUMBER_ROUND || rd_count == NUMBER_ROUND_INC);

endmodule
