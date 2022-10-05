`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2022 09:03:32 PM
// Design Name: 
// Module Name: count_m
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


module count_m(
    input logic clk, rst, enb,adv_min,
    output logic cy,
    output logic [6:0] m_tens, m_ones
    );
    
    logic[5:0]q;
    
    logic[3:0] hundreds, tens, ones;
    logic enb_c;
    
    assign enb_c = enb | adv_min;
    
    counter_rc_mod #(.MOD(60),.W(6)) COUNTER (.clk(clk), .rst(rst),.enb(enb),.q(q),.cy(cy));
    dbl_dabble_ext BINARY_TO_BCD(.b({2'd0,q}),.hundreds(hundreds),.tens(tens),.ones(ones));
    
    
    assign m_tens = {3'd0, tens};
    assign m_ones = {3'b010, ones}; 
    
endmodule
