
module traffic_light_controller_tb();
     
	  reg X,clock,reset;
	  wire [1:0] hwy,cntry;
	  
	  traffic_light_controller DUT(hwy,cntry,X,clock,reset);
	  
	  
	  //clock generation
	  initial 
	     begin
		    clock = 1'b0;
          forever #5 clock = ~clock;
        end
		  
	  initial 
	     begin
		     reset = 1'b1;
			  repeat(5) @(negedge clock);
			  reset = 1'b0;
		  end
	  
	  initial 
	     begin
		     X = 1'b0;
			  
			  #20 X = 1'b1;
			  #10 X = 1'b0;
			  
			  #20 X = 1'b1;
			  #10 X = 1'b0;
		  end
endmodule
			  
    		  