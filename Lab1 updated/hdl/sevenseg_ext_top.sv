`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2022 10:12:25 AM
// Design Name: 
// Module Name: sevenseg_ext_top
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


module sevenseg_ext_top(input logic [6:0] SW, output logic [6:0] segs_n, output logic [7:0] an_n, output logic DP );
   sevenseg_ext_n U_INST1 (.data(SW), .segs_n(segs_n), .dp_n(DP));
   assign an_n = 8'b11111110;


endmodule