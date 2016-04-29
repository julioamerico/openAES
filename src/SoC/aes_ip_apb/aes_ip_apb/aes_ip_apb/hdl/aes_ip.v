module aes_ip
(
	//OUTPUTS
	output int_ccf,
	output int_err,
	output [1:0] dma_req,
	output PREADY,
	output PSLVERR,
	output [31:0] PRDATA,
	//INPUTS
	input  [31:0] PADDR,
	input  [31:0] PWDATA,
	input PWRITE,
	input PENABLE,
	input PSEL,
	input PCLK,
	input PRESETn
);

wire [31:0] col_out;
wire [31:0] key_out;
wire [31:0] iv_out;
wire end_aes;
wire [ 3:0] iv_en;
wire [ 3:0] iv_sel_rd;
wire [ 3:0] key_en;
wire [ 1:0] key_sel_rd;
wire [ 1:0] data_type;
wire [ 1:0] addr;
wire [ 1:0] op_mode;
wire [ 1:0] aes_mode;
wire start;
wire disable_core;
wire write_en;
wire read_en;
wire first_block;
wire dma_req_wr;
wire dma_req_rd;
wire [3:0] host_addr;


assign PREADY = 1'b1;
assign PSLVERR = 1'b0;


assign host_addr = PADDR[5:2];
assign dma_req = {dma_req_wr, dma_req_rd};

host_interface HOST_INTERFACE
(
	.key_en       ( key_en       ),
	.col_addr     ( addr         ),
	.col_wr_en    ( write_en     ),
	.col_rd_en    ( read_en      ),
	.key_sel      ( key_sel_rd   ),
	.iv_en        ( iv_en        ),
	.iv_sel       ( iv_sel_rd    ),
	.int_ccf      ( int_ccf      ),
	.int_err      ( int_err      ),
	.chmod        ( aes_mode     ),
	.mode         ( op_mode      ),
	.data_type    ( data_type    ),
	.disable_core ( disable_core ),
	.first_block  ( first_block  ),
	.dma_req_wr   ( dma_req_wr   ),
	.dma_req_rd   ( dma_req_rd   ),
	.start_core   ( start        ),
	.PRDATA       ( PRDATA       ),
	.PADDR        ( host_addr    ),
	.PWDATA       ( PWDATA       ),
	.PWRITE       ( PWRITE       ),
	.PENABLE      ( PENABLE      ),
	.PSEL         ( PSEL         ),
	.PCLK         ( PCLK         ),
	.PRESETn      ( PRESETn      ),
	.key_bus      ( key_out      ),
	.col_bus      ( col_out      ),
	.iv_bus       ( iv_out       ),
	.ccf_set      ( end_aes      )
); 

aes_core AES_CORE
(
	.col_out      ( col_out      ),
	.key_out      ( key_out      ),
	.iv_out       ( iv_out       ),
	.end_aes      ( end_aes      ),
	.bus_in       ( PWDATA       ),
	.iv_en        ( iv_en        ),
	.iv_sel_rd    ( iv_sel_rd    ),
	.key_en       ( key_en       ),
	.key_sel_rd   ( key_sel_rd   ),
	.data_type    ( data_type    ),
	.addr         ( addr         ),
	.op_mode      ( op_mode      ),
	.aes_mode     ( aes_mode     ),
	.start        ( start        ),
	.disable_core ( disable_core ),
	.write_en     ( write_en     ),
	.read_en      ( read_en      ),
	.first_block  ( first_block  ),
	.rst_n        ( PRESETn      ),
	.clk          ( PCLK         )
);
endmodule