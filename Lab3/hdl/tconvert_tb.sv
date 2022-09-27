`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2022 08:57:14 PM
// Design Name: 
// Module Name: tconvert_tb
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


module tconvert_tb();
    
       //inputs
       logic clk;
       logic [12:0] tc;
       logic c_f;
       
       //outputs
       logic [17:0] tx10;
        
        
       //instantiate DUV
       tconvert DUV (.tc, .c_f, .tx10);
       
       //generate clock 
       parameter CLK_PD = 10;
       
       always begin
            clk = 1'b0; #(CLK_PD/2);
            clk = 1'b1; #(CLK_PD/2);
       end
       
       //sequence the input stimulus
       //
       initial begin
            c_f = 0; @(posedge clk)#1;
            tc = 000011001; #(CLK_PD*10);
            c_f = 1;
            tc = 000000000; #(CLK_PD*10);
         $stop;
       end
endmodule
