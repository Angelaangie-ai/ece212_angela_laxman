`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 10:20:44 AM
// Design Name: 
// Module Name: count_m_tb
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


module count_m_tb;
    logic clk, rst, enb, cy, adv_min;
    logic [6:0] m_tens, m_ones;
  //  logic[3:0] hundreds, tens, ones;
  //  logic [5:0] q;
    
    count_m COUNT_MINUTES (.clk, .rst, .enb, .cy, .m_tens, .m_ones, .adv_min);
    
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
        adv_min = 1;
        @ (posedge clk) #1;
        rst = 0;
        enb = 1;
        adv_min = 0;
        repeat (65) @ (posedge clk) #1;
        $stop;
    end


endmodule
