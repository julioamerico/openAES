`define STOP
module tb_mix_columns();
  
  reg [31:0] col_in;
  wire [31:0] col_out;
  wire [31:0] col_out_dec;
  
  mix_columns MIX_COL
  (
    .mix_out_enc ( col_out     ),
		.mix_out_dec (  ),
    .mix_in      ( col_in      )
  );
 
  mix_columns MIX_COL_DEC
  (
    .mix_out_enc (   ),
		.mix_out_dec ( col_out_dec ),
    .mix_in      ( col_out     )
  );

task check;
	input [31:0] col_golden;
	input [31:0] col_in;
	begin
		if(col_golden != col_in)
				begin
					$display("Error");
					`ifdef STOP
						$stop;
					`endif
				end
	end
endtask

  initial
    begin
      col_in = 32'hd4_bf_5d_30;
      #5;
			check(col_out_dec, col_in);
      col_in = 32'he0_b4_52_ae;
      #5;
			check(col_out_dec, col_in);
      col_in = 32'hb8_41_11_f1;
      #5;
			check(col_out_dec, col_in);
      col_in = 32'h1e_27_98_e5;
      #5
			check(col_out_dec, col_in);
      col_in = 32'h30_5d_bf_d4;
			#5
			check(col_out_dec, col_in);
			$display("TEST PASSED!!!");
			$stop;
    end
endmodule
