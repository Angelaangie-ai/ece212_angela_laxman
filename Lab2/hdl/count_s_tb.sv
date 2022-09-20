`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 09:26:01 AM
// Design Name: 
// Module Name: count_s_tb
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


module count_s_tb;

    logic clk, rst, enb, cy;
    logic [6:0] s_tens, s_ones;
  //  logic[3:0] hundreds, tens, ones;
  //  logic [5:0] q;
    
    count_s COUNT_SECONDS (.clk, .rst, .enb, .cy, .s_tens, .s_ones);
    
    //counter_rc_mod #(.MOD(60),.W(6)) COUNTER (.clk, .rst,.enb,.q,.cy);
    //dbl_dabble_ext BINARY_TO_BCD(.b({6'd0,q}),.hundreds,.tens,.ones);
    
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end
    
    initial begin
        rst = 1;
        enb = 0;
        @ (posedge clk) #1;
        rst = 0;
        enb = 1;
        repeat (65) @ (posedge clk) #1;
        $stop;
    end

endmodule
