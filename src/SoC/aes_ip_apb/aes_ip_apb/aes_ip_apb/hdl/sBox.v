module sBox
#(
  parameter SBOX_NUM = 4
)(
  //OUTPUTS
  output [8*SBOX_NUM - 1:0] sbox_out_enc,
  output [8*SBOX_NUM - 1:0] sbox_out_dec,
	//INPUTS
  input  [8*SBOX_NUM - 1:0] sbox_in,
	input enc_dec,
	input clk
);
  sBox_8 SBOX[SBOX_NUM - 1:0]
  (
    .sbox_out_enc ( sbox_out_enc ),
		.sbox_out_dec ( sbox_out_dec ),
    .sbox_in      ( sbox_in      ),
		.enc_dec      ( enc_dec      ),
		.clk          ( clk          )
  );
  
endmodule