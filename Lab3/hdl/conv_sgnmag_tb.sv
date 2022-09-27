`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2022 08:49:18 PM
// Design Name: 
// Module Name: conv_sgnmag_tb
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


module conv_sgnmag_tb();

       //inputs
       logic clk;
       logic signed [17:0] tx10;
       
       //outputs
       logic tx10_sign;
       logic [16:0] tx10_mag;
        
        
       //instantiate DUV
       conv_sgnmag DUV (.tx10, .tx10_sign, .tx10_mag);
       
       //generate clock 
       parameter CLK_PD = 10;
       
       always begin
            clk = 1'b0; #(CLK_PD/2);
            clk = 1'b1; #(CLK_PD/2);
       end
       
       //sequence the input stimulus
       //
       initial begin
            tx10 = 18'b111111111111111011; #(CLK_PD*2);  //this is -5 in 2's complement
            tx10 = 18'b111111111111111001; #(CLK_PD*2); //-7 in two's complement we should be outputing 17'b00000000000000111 and a sign bit of 1
            tx10 = 18'b000000000000001000; #(CLK_PD*2); //8 is positive and we should not be evaluating it, we should simply output the magnitude as it is
         $stop;
       end

endmodule
