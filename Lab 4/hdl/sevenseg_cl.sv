`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 10:31:16 AM
// Design Name: 
// Module Name: sevenseg_cl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevenseg_cl(
		 input logic [6:0]  data,
		 output logic [6:0] segs_n,  // ordered g(6) - a(0)
		 output logic dp_n
		 );

   always_comb
   begin
   
    case (data[3:0])     //  gfedcba
       4'd0: segs_n = 7'b1000000;
       4'd1: segs_n = 7'b1111001;
       4'd2: segs_n = 7'b0100100;
       4'd3: segs_n = 7'b0110000;
       4'd4: segs_n = 7'b0011001;
       4'd5: segs_n = 7'b0010010;
       4'd6: segs_n = 7'b0000010;
       4'd7: segs_n = 7'b1111000;
       4'd8: segs_n = 7'b0000000;
       4'd9: segs_n = 7'b0010000;
       4'd10: segs_n = 7'b0001000;  
       4'd11: segs_n = 7'b0001100;  
       4'd12: segs_n = 7'b1000110;
       4'd15: segs_n = 7'b0001110;
       default: segs_n = 7'b1111111;
     endcase
     
      dp_n=!data[5];
      
      if (data[4]) 
    begin
        segs_n = 7'b0111111;
        
        
    end 
   if (data[6]) 
     begin
        segs_n = 7'b1111111;
        dp_n=1'b1;
     end  
   end
endmodule: sevenseg_cl