`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 10:05:28 AM
// Design Name: 
// Module Name: conv_sgnmag
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


module conv_sgnmag( input logic signed [17:0] tx10,
                    output logic tx10_sign,
                    output logic [16:0] tx10_mag);
                    
         logic tx10_s_wire; //wire to hold the sign bit
         logic [16:0] inv_b_wire; //wire to hold the inverted magnitude
         logic [16:0] add_one_wire; //wire to hold the inverted bits + 1
         
         assign tx10_s_wire = tx10[17];  //assign sign wire to most significant bit
                  
         assign inv_b_wire = ~tx10[16:0];  //invert the bits
         assign add_one_wire = inv_b_wire + 1'b1;  //add one
                    
         assign tx10_mag = (tx10_s_wire) ? add_one_wire : tx10[16:0];  //multiplexer with the sign bit as select input, the select input will convert two's complement to sign magnitude if the most significant bit is negative
         assign tx10_sign = tx10[17]; //set the one bit sign output to the most significant bit of the input
                    
                    
endmodule
