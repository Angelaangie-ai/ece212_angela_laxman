`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2022 08:40:30 AM
// Design Name: 
// Module Name: sevenseg_ext_n
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

//-----------------------------------------------------------------------------
// Module Name   : seven_seg_n: Seven-segment decoder with active low outputs
// Project       : RTL Hardware Design and Verification using SystemVerilog
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Feb 2020
//-----------------------------------------------------------------------------
// Description   : BCD seven-segment decoder with active low outputs.
// Segments are ordered as follows: segs_n[6]=g, segs_n[0]=a
//-----------------------------------------------------------------------------

module sevenseg_ext_n(
		 input logic [6:0]  data,
		 output logic [6:0] segs_n,  // ordered g(6) - a(0)
		 output logic dp_n
		 );

   always_comb
   begin
   
   if (data[6]) 
    begin
        segs_n = 7'b1111111;
        dp_n=1'b1;
    end 
   
   
   else if (data[5]) 
    begin
        segs_n = 7'b1111111;
        dp_n=1'b0;
    end
    
 
   else if (data[4]) 
    begin
        segs_n = 7'b0111111;
        dp_n=1'b1;
    end
    
    else
    begin
     dp_n=1'b1;
     
     case (data)     //  gfedcba
       7'd0: segs_n = 7'b1000000;
       7'd1: segs_n = 7'b1111001;
       7'd2: segs_n = 7'b0100100;
       7'd3: segs_n = 7'b0110000;
       7'd4: segs_n = 7'b0011001;
       7'd5: segs_n = 7'b0010010;
       7'd6: segs_n = 7'b0000010;
       7'd7: segs_n = 7'b1111000;
       7'd8: segs_n = 7'b0000000;
       7'd9: segs_n = 7'b0010000;
       7'd10: segs_n = 7'b0001000;
       7'd11: segs_n = 7'b0001100;
       7'd12: segs_n = 7'b1000011;
       7'd15: segs_n = 7'b0001011;
       default: segs_n = 7'b1111111;
     endcase
     end
     
     end
endmodule: sevenseg_ext_n