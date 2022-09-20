`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2022 09:04:00 PM
// Design Name: 
// Module Name: count_s
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


module count_s(
    input logic clk, rst, enb,
    output logic cy,
    output logic [6:0] s_tens, s_ones
    );
    
    logic[5:0]q;
    
    logic[3:0] hundreds, tens, ones;
    
    counter_rc_mod #(.MOD(60),.W(6)) COUNTER (.clk(clk), .rst(rst),.enb(enb),.q(q),.cy(cy));
    dbl_dabble_ext BINARY_TO_BCD(.b({2'd0,q}),.hundreds(hundreds),.tens(tens),.ones(ones));
    
    
    assign s_tens = {3'd0, tens};
    assign s_ones = {3'd0, ones}; 
endmodule
