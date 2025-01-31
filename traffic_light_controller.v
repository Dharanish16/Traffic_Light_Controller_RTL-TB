
`define TRUE 1'b1
`define FALSE 1'b0

//Delays 
`define Y2RDELAY 3  //YELLOW to RED delay 
`define R2GDELAY 2  //RED to GREEN delay 

module traffic_light_controller(hwy,cntry,X,clock,reset);
       
		 output reg [1:0] hwy,cntry;
		     //2-bit outputs to represent the 3 states of output RED,GREEN,YELLOW
		 input X,reset,clock;
		     //if TRUE, indicates that there is car on the country road otherwise FALSE 
		 
		 reg [2:0]present_state;
		 reg [2:0]next_state;
		 
		 parameter RED = 2'd0,
		           YELLOW = 2'd1,
					  GREEN = 2'd2;
					  
		 //state definition        HWY      COUNTRY
		 parameter S0 = 3'd0, //GREEN       RED  
		           S1 = 3'd1, //YELLOW      RED 
					  S2 = 3'd2, //RED         RED
					  S3 = 3'd3, //RED         GREEN
					  S4 = 3'd4; //RED         YELLOW
		
		//state changes only at positive edge of clock 
		always @(posedge clock)
		  begin
		    if(reset)
		        present_state <= S0;
			 else 
			     present_state <= next_state;
		  end
			 
	   always@(present_state)
		    begin
			    case(present_state)
				     S0   : begin
					             hwy = GREEN;
									 cntry = RED;
							    end
					  S1   : begin
					              hwy = YELLOW;
									  cntry = RED;
								 end
					  S2   : begin
					              hwy = RED;
									  cntry = RED;
								 end
					  S3   : begin
					              hwy = RED;
									  cntry = GREEN;
								 end
					  S4   : begin
					              hwy = RED;
									  cntry = YELLOW;
								 end
				endcase 
	       end
		
		always@(present_state or X)
		    begin
				     case(present_state)
					        S0  : if(X)
							            next_state = S1;
										else
										   next_state = S0;
							  S1  : begin
							            repeat(`Y2RDELAY) @(posedge clock);
											next_state = S2;
										end
							  S2  : begin
							            repeat(`R2GDELAY) @(posedge clock);
											next_state = S3;
										end
							  S3  : begin
							            if(X)
											   next_state = S3;
										   else
											   next_state = S4;
										end
							  S4  : begin
							            repeat(`Y2RDELAY) @(posedge clock);
											next_state = S0;
										end
							  default : next_state = S0;
					  endcase 
			  end
endmodule

		 
		 