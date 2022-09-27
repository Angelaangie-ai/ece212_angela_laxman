`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2022 09:03:43 PM
// Design Name: 
// Module Name: tdisplay_tb
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


module tdisplay_tb();
    
    //inputs
       logic clk, c_f;
       logic [12:0] tc;

       
       //outputs
       logic [3:0] thousands, hundreds, tens, ones;
       logic sign;
        
        
       //instantiate DUV
       tdisplay DUV (.tc, .c_f, .thousands, .hundreds, .tens, .ones, .sign);
       
       //generate clock 
       parameter CLK_PD = 10;
       
       always begin
            clk = 1'b0; #(CLK_PD/2);
            clk = 1'b1; #(CLK_PD/2);
       end
       
       //sequence the input stimulus
       //
       initial begin
            c_f = 0;
            tc = {9'd5, 4'd0};
            #10;
            tc = 13'b0111111111111;
            #10;
            tc = 13'b1111111110000;
            #10;
            tc = 13'b1111111111011; #10; //-5 in twos complement
            #10;
            tc = 13'b1; #10;
            #10;
            c_f = 1;
            tc = 13'd0;
            #10
         
         $stop;
       end
endmodule
