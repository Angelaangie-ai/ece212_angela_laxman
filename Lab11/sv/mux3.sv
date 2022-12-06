`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2022 09:49:28 AM
// Design Name: 
// Module Name: mux3
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


module mux3 #(parameter W=32)
             (input logic [W-1:0]  d0, d1, d2,
              input logic [1:0]    s,
              output logic [W-1:0] y );

   always_comb
     case (s)
       2'd0 : y = d0;
       2'd1 : y = d1;
       2'd2 : y = d2;
       default : y = 0;
     endcase

endmodule: mux3
