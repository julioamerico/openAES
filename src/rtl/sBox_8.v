//Reference: A Very Compact Rijndael S-box, D. Canright

module sBox_8
(
  //OUTPUTS
  output [7:0] sbox_out_enc, // Direct SBOX
	output [7:0] sbox_out_dec, // Inverse SBOX
  //INPUTS
  input  [7:0] sbox_in,
	input enc_dec,
	input clk
);
`include "sbox_functions.vf"

wire [7:0] base_new_enc, base_new_dec, base_new;
wire [7:0] base_enc, base_dec;
wire [3:0] out_gf_inv8_stage1;
wire [7:0] out_gf_inv8_1;
wire [7:0] out_gf_inv8_2;

reg [3:0] out_gf_pp;
reg [7:0] base_new_pp;

assign {base_new_enc, base_new_dec} = isomorphism(sbox_in);

assign base_new = ~(enc_dec ? base_new_enc : base_new_dec);
assign out_gf_inv8_stage1 = gf_inv_8_stage1(base_new);

always @(posedge clk)
	begin
		out_gf_pp <= out_gf_inv8_stage1;
		base_new_pp <= base_new;
	end

assign out_gf_inv8_1 = gf_inv_8_stage2(base_new_pp, out_gf_pp);				
	
assign sbox_out_enc = ~isomorphism_inv(out_gf_inv8_1, ENC);
assign sbox_out_dec = ~isomorphism_inv(out_gf_inv8_1, DEC);

endmodule