`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2022 08:41:45 PM
// Design Name: 
// Module Name: tdisplay
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

module tdisplay(input logic signed [12:0] tc,
                input logic c_f,
                output logic [3:0] thousands, hundreds, tens, ones,
                output logic sign);
                
logic signed [17:0] tx10;                
logic [16:0] tx10_mag;
logic [12:0] tx10_mag_r;         
          

tconvert U_CONVERT (.tc (tc), .c_f (c_f), .tx10(tx10));

conv_sgnmag U_SIGN_MAG (.tx10(tx10), .tx10_sign(sign), .tx10_mag(tx10_mag));

round U_ROUND (.tx10_mag(tx10_mag), .tx10_mag_r(tx10_mag_r));

dbl_dabble_ext U_DABBLE (.b(tx10_mag_r), .thousands(thousands), .hundreds(hundreds), .tens(tens), .ones(ones));

    
endmodule
