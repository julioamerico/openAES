module tb_sBox();
  
  reg  [7:0] sbox_in;
  reg [31:0] sbox32_in;
  reg enc_dec;
  reg  [4:0] x, y;
	reg clk;
  
  wire  [7:0] sbox_out;
  wire [31:0] sbox32_out;
  wire  [7:0] sbox_out_inv;
  wire  [7:0] sbox_ident;
  
  sBox_8 SBOX
  (
    .sbox_out_enc ( sbox_out        ),
		.sbox_out_dec ( ),
    .sbox_in      ( {x[3:0],y[3:0]} ),
		.enc_dec      ( enc_dec      ),
		.clk          ( clk )
  );
  
 sBox_8 SBOX_INV
  (
    .sbox_out_enc ( ),
		.sbox_out_dec ( sbox_out_inv    ),
    .sbox_in      ( {x[3:0],y[3:0]} ),
		.enc_dec      ( ~enc_dec        ),
		.clk          ( clk )
  );

  sBox_8 SBOX_INV_2
  (
		.sbox_out_enc (  sbox_ident),
    .sbox_out_dec (    ),
    .sbox_in      ( sbox_out_inv ),
		.enc_dec      ( enc_dec     ),
		.clk          ( clk )
  );
 /* 
  sBox SBOX32
  (
    .sbox_out_enc ( sbox32_out ),
		.sbox_out_dec (),
    .sbox_in  ( sbox32_in  ),
    .enc_dec  ( enc_dec  )
  );
 */ 
  initial
    begin
      sbox32_in = 32'h19_3d_e3_be;
    end
  
  initial
    begin
      enc_dec = 1'b1;
			clk = 0;
      $display("S-Box:");
      for(x = 0; x < 16; x = x + 1)
        begin
          for(y = 0; y < 16; y = y + 1)
            begin
                @(posedge clk); 
								$write("%x ", sbox_out);
            end
          #1 $write("\n");
        end
      $display("\nInv S-Box:");
      for(x = 0; x < 16; x = x + 1)
        begin
          for(y = 0; y < 16; y = y + 1)
            begin
                @(posedge clk); 
							  $write("%x ", sbox_out_inv);
            end
          #1 $write("\n");
        end
      $display("Ident:");
      for(x = 0; x < 16; x = x + 1)
        begin
          for(y = 0; y < 16; y = y + 1)
            begin
              	@(posedge clk); 
								@(posedge clk);
								@(posedge clk);
              if(sbox_ident != {x[3:0], y[3:0]})
                begin
                  $display("ERROR! - %x != %x", sbox_ident, {x[3:0], y[3:0]});
                  $finish;
                end
              else
                #1 $write("%x ", sbox_ident);
            end
          #1 $write("\n");
        end
				$display("TEST PASSED!!!");
				x = 0;
				y = 0;
				enc_dec = 0;
				repeat(4)
					@(posedge clk);
				@(negedge clk);
				{x[3:0],y[3:0]} = 8'd0;
				@(posedge clk);
				{x[3:0],y[3:0]} = 8'd1;
				@(posedge clk);
				{x[3:0],y[3:0]} = 8'd2;
				@(posedge clk);
				{x[3:0],y[3:0]} = 8'd3;
				@(posedge clk);			
	        $stop;    
    end

always #10
	clk = !clk;

endmodule
