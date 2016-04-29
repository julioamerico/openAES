module tb_data_swap();

wire [31:0] data_out;
reg  [31:0] data_in;
reg  [ 1:0] type;

data_swap SWAP
(
	.data_swap( data_out),
	.data_in  ( data_in ),
	.swap_type( type    )
);

initial
	begin
		type = 2'b00;
		data_in = 32'hab_cd_ef_12;
	end
endmodule
