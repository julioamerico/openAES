module host_interface
(
	// OUTPUTS
	output [3:0] key_en,
	output [1:0] col_addr,
	output [1:0] chmod,
	output [1:0] mode,
	output [1:0] data_type,
	output col_wr_en,
	output col_rd_en,
	output [1:0] key_sel,
	output [3:0] iv_en,
	output [3:0] iv_sel,
	output int_ccf,
	output int_err,
	output disable_core,
	output reg first_block,
	output dma_req_wr,
	output dma_req_rd,
	output reg start_core,
	output [31:0] PRDATA,
	//INPUTS
	input [3:0] PADDR,
	input [31:0] PWDATA,
	input PWRITE,
	input PENABLE,
	input PSEL,
	input PCLK,
	input PRESETn,
	input [31:0] key_bus,
	input [31:0] col_bus,
	input [31:0] iv_bus,
	input ccf_set
);

`include "host_interface.h"

//=============================================================================
// Resets Values
//=============================================================================
localparam AES_CR_RESET = 13'd0;
localparam AES_SR_RESET =  3'd0;

//=============================================================================
// Enable Value (Active High)
//=============================================================================
localparam ENABLE  = 1'b1;
localparam DISABLE = 1'b0;

//=============================================================================
// FSM STATES
//=============================================================================
localparam IDLE   = 3'd0;
localparam INPUT  = 3'd1;
localparam START  = 3'd2;
localparam WAIT   = 3'd3;
localparam OUTPUT = 3'd4;

reg [31:0] bus_out;
reg [31:0] bus_out_mux;
reg cnt_en;
reg enable_clear;
reg access_permission;
reg first_block_set;
reg first_block_clear;
wire [1:0] mode_in;
wire [1:0] chmod_in;
wire write_en;
wire read_en;
wire dma_out_en;
wire dma_in_en;
wire err_ie;
wire ccf_ie;
wire errc;
wire ccfc;
wire aes_cr_wr_en;
wire wr_err_en;
wire rd_err_en;
wire write_completed;
wire read_completed;
wire key_deriv;


reg [10:0] aes_cr;
reg wr_err;
reg rd_err;
reg ccf;
reg [2:0] state, next_state;
reg [1:0] cnt;
reg dma_req;

// Write and read enable signals
assign write_en = PSEL & PENABLE & PWRITE;
assign read_en  = PSEL & ~PWRITE;

// Configuration Register Logic
assign dma_out_en = aes_cr[10];
assign dma_in_en  = aes_cr[9];
assign err_ie     = aes_cr[8];
assign ccf_ie     = aes_cr[7];
assign errc       = PWDATA[8];
assign ccfc       = PWDATA[7];
assign chmod      = aes_cr[6:5];
assign mode       = aes_cr[4:3];
assign data_type  = aes_cr[2:1];
assign enable     = aes_cr[0];

assign aes_cr_wr_en = (PADDR == AES_CR) & write_en;
assign mode_in  = PWDATA[4:3];
assign chmod_in = PWDATA[6:5];

always @(posedge PCLK, negedge PRESETn)
	begin
		if(!PRESETn)
			aes_cr <= AES_CR_RESET;
		else
			begin
				if(enable_clear)
					aes_cr[0] <= 1'b0;
				else
					if(aes_cr_wr_en)
						aes_cr[0] <= PWDATA[0];

				if(aes_cr_wr_en && access_permission)
					begin
						aes_cr[2:1] <= PWDATA[2:1];
						if(mode_in == DECRYP_W_DERIV && chmod_in == CTR)
							aes_cr[4:3] <= DECRYPTION;
						else
							aes_cr[4:3] <= mode_in;
						aes_cr[ 6:5] <= PWDATA[6:5];
						aes_cr[10:7] <= PWDATA[12:9];
					end
			end
	end
 
// Status Register Logic
assign aes_sr_wr_en = (PADDR == AES_SR) & write_en & access_permission;

always @(posedge PCLK, negedge PRESETn)
	begin
		if(!PRESETn)
			{wr_err, rd_err, ccf} <= AES_SR_RESET;
		else
			begin
				// Write Error Flag
				if(wr_err_en)
					wr_err <= 1'b1;
				else
					if(errc && aes_cr_wr_en && access_permission)
						wr_err <= 1'b0;

				//Read Error Flag
				if(rd_err_en)
					rd_err <= 1'b1;
				else
					if(errc && aes_cr_wr_en && access_permission)
						rd_err <= 1'b0;

				// Computation Complete Flag
				if(ccf_set)
					ccf <= 1'b1;
				else
					if(ccfc && aes_cr_wr_en && access_permission)
						ccf <= 1'b0;
			end
	end
// Interruption on erros Signals
assign int_ccf = ccf_ie & ccf_set;
assign int_err = (wr_err_en | rd_err_en) & err_ie;

// Key Signals Decoding
assign key_en = (4'b1000 >> PADDR[1:0]) & {4{(~PADDR[3] & PADDR[2] & access_permission & write_en)}};
assign key_sel = ~PADDR[1:0] & {2{(PADDR[2] & access_permission)}};

// IV Signals Decoding
assign iv_sel = (4'b1000 >> PADDR[1:0]) & {4{(PADDR[3] & ~PADDR[2] & access_permission)}};
assign iv_en = iv_sel & {4{write_en}};

// State Register
always @(posedge PCLK, negedge PRESETn)
	begin
		if(!PRESETn)
			state <= IDLE;
		else
			if(!enable)
				state <= IDLE;
			else
				state <= next_state;
	end

assign write_completed = (cnt == 2'b11);
assign read_completed  = (cnt == 2'b11);
assign key_deriv = (mode == KEY_DERIVATION);

// Next State Logic
always @(*)
	begin
		next_state = state;
		case(state)
		IDLE  :
			begin
				if(enable)
					next_state = (key_deriv) ? START : INPUT;
			end
		INPUT :
			next_state = (write_completed && cnt_en) ? START : INPUT;
		START :
			next_state = WAIT;
		WAIT  :
			begin
				if(ccf_set)
					next_state = (key_deriv) ? IDLE : OUTPUT;
			end
		OUTPUT:
			next_state = (read_completed && cnt_en) ? INPUT : OUTPUT;
		endcase
	end

// Output Logic
assign disable_core = ~enable;

always @(*)
	begin
		access_permission = DISABLE;
		start_core = DISABLE;
		cnt_en = DISABLE;
		enable_clear = DISABLE;
		first_block_set = DISABLE;
		first_block_clear = DISABLE;
		case(state)
			IDLE:
				begin
					access_permission = ENABLE;
					first_block_set = ENABLE;
					if(enable && !key_deriv)
						cnt_en = ENABLE;
				end
			INPUT:
				begin
					if(PADDR == AES_DINR && write_en)
						cnt_en = ENABLE;
				end
			START:
				begin
					start_core = ENABLE;
				end
			WAIT:
				begin
					if(ccf_set)
						cnt_en = ENABLE;
					if(ccf_set && key_deriv)
						enable_clear = ENABLE;
				end
			OUTPUT:
				begin
					first_block_clear = ENABLE;
					if(PADDR == AES_DOUTR && read_en && PENABLE )//|| write_completed)
						cnt_en = ENABLE;
				end
		endcase
	end

// First Block Signal indicates when IV register is used
always @(posedge PCLK, negedge PRESETn)
	begin
		if(!PRESETn)
			first_block <= 1'b1;
		else
			if(first_block_set)
				first_block <= 1'b1;
			else
				if(first_block_clear)
					first_block <= 1'b0;
	end

always @(posedge PCLK, negedge PRESETn)
	begin
		if(!PRESETn)
			cnt <= 2'b11;
		else
			begin
				if(!enable || state == START)
					cnt <= 2'b11;
				else
					if(cnt_en)
						cnt <= cnt + 1'b1;
			end
	end

assign col_addr = cnt;
assign col_wr_en = (PADDR == AES_DINR  && write_en && state == INPUT);
assign col_rd_en = (PADDR == AES_DOUTR && read_en  && state == OUTPUT);
assign wr_err_en = (PADDR == AES_DINR  && write_en && (state != INPUT  && state != IDLE));
assign rd_err_en = (PADDR == AES_DOUTR && read_en  && (state != OUTPUT && state != IDLE));

// DMA Requests Logic
always @(posedge PCLK, negedge PRESETn)
	begin
		if(!PRESETn)
			dma_req <= 0;
		else
			dma_req <= cnt[0];
	end

assign dma_req_wr = (dma_req ^ cnt[0]) & dma_in_en  & enable & (state == INPUT  || state == IDLE);
assign dma_req_rd = (dma_req ^ cnt[0]) & dma_out_en & enable & (state == OUTPUT);

// APB Read Signal
assign PRDATA = bus_out;

// Output Mux
always @(*)
	begin
		bus_out_mux = 32'd0;
		case(PADDR)
			AES_CR:
				bus_out_mux = {{19{1'b0}}, aes_cr[10:7], 2'b00, aes_cr[6:0]};
			AES_SR:
				bus_out_mux = {{29{1'b0}}, wr_err, rd_err, ccf};
			AES_DINR, AES_DOUTR:
				bus_out_mux = col_bus;
			AES_KEYR0, AES_KEYR1, AES_KEYR2, AES_KEYR3:
				bus_out_mux = key_bus;
			AES_IVR0, AES_IVR1, AES_IVR2, AES_IVR3:
				if(!enable)
					bus_out_mux = iv_bus;
		endcase
	end

// The output Bus is registered
always @(posedge PCLK, negedge PRESETn)
	begin
		if(!PRESETn)
			bus_out <= 32'd0;
		else
			if(read_en)
				bus_out <= bus_out_mux;
	end

endmodule
