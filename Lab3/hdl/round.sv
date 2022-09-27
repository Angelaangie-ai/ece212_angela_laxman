`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 10:06:13 AM
// Design Name: 
// Module Name: round
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


module round( input logic [16:0] tx10_mag,
              output logic [12:0] tx10_mag_r );
              
              assign tx10_mag_r = tx10_mag[16:4] + tx10_mag[3];
endmodule
