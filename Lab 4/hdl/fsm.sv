module fsm( input logic clk,rst, enb2s,
            input logic [1:0] in,
			output logic c_f, dsel);

 
 typedef enum logic [2:0]{ 
    DTIME= 3'b000, DTF = 3'b001, DTC = 3'b010  
    }state_t ;


 state_t state, next ; 

 always_ff @(posedge clk) 

 	if(rst) state <= DTIME; 
 	else state <= next; 

 	always_comb 
 		begin 

 			dsel = 0;
 			c_f = 0;
  			next = DTIME; 

 // Creating case statements 

 			case(state) 

 		DTIME: 
 		begin 
 				
 				if(enb2s && ((in == 2'b01) || (in==2'b11)))
 				 next = DTF;
 				
 				else if (enb2s && ((in ==2'b10)))
 				next = DTC;
 				
 				else 
 				next = DTIME;
        end 

 		DTF: 
 		 begin 
           dsel = 1;
 	       c_f = 1;
 						
 			      if (enb2s && (in== 2'b11 ))
 			        next = DTC;
 			      else if (enb2s && (in==2'b00))
 			        next = DTIME;
 			      else if(!enb2s)
 			        next = DTF;
 			      else 
 			        next = DTIME;
 			   				      
 		end 
 		DTC: 
 		     begin
 		      dsel = 1;
 		      c_f=0;
 		      
 		      if (enb2s && in== 2'b11)
 		        next = DTIME;
 		       else if (!enb2s) 
 		        next = DTC;
 		       else 
 		        next = DTIME;
 		     
 					
 			end 

 					endcase 
 				end 
 			endmodule // reaction fsm
