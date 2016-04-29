module tb_shift_rows();
  
  wire [127:0] data_sft_dec;
  wire [127:0] data_sft_l, data_sft_r;
  
  reg [127:0] data_in;
  reg enc_dec;
  
  shift_rows SR_ENC
  (
    //OUTPUTS
    .data_out_enc  ( data_sft_l ),
		.data_out_dec  ( data_sft_r ),
    //INPUTS
    .data_in   ( data_in  ) 
  );
  
shift_rows SR_DEC
  (
    //OUTPUTS
    .data_out_enc  ( ),
		.data_out_dec  ( data_sft_dec ),
    //INPUTS
    .data_in   ( data_sft_l  ) 
  );
  
  integer i;
  initial
    begin
      enc_dec = 1;
			data_in = {32'h0F_0E_0D_0C, 32'h0B_0A_09_08, 32'h07_06_05_04, 32'h03_02_01_00};
			#5
			if(data_in != data_sft_dec)
				begin
					$display("Error");
					$stop;
				end
			data_in = {32'h08_48_f8_e9, 32'h2a_8d_c6_9a, 32'h2b_e2_f4_a0, 32'hbe_e3_3d_19};
    	#5
			if(data_in != data_sft_dec)
				begin
					$display("Error");
					$stop;
				end
			data_in = 128'h63cab7040953d051cd60e0e7ba70e18c;
			#5;
			if(data_in != data_sft_dec)
				begin
					$display("Error");
					$stop;
				end
			data_in = 128'h3243f6a8885a308d313198a2e0370734;
			#5;
			if(data_in != data_sft_dec)
				begin
					$display("Error");
					$stop;
				end	
			$display("TEST PASSED!!");
		end
endmodule
