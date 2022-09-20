`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2022 09:59:03 PM
// Design Name: 
// Module Name: top_module
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


module top_module( input logic clk,btn_d, btn_l, btn_r,
                   output logic [7:0] an_n, 
                   output logic [6:0] segs_n,
                   output logic dp_n);
                   logic [6:0]  blank;
                   logic [6:0] h1, h0, m_tens, m_ones, s_tens, s_ones, am_pm;
                   assign blank = 7'b1000000;
                   

        sevenseg_ctl U_1 (.d7(h1),.d6(h0),.d5(m_tens),.d4(m_ones),.d3(s_tens),.d2(s_ones),.d1(blank),.d0(am_pm), .segs_n(segs_n), .an_n(an_n)
        ,.clk(clk),.rst(btn_d),.dp_n(dp_n));
        dig_clock(.clk(clk), .rst(btn_d), .h1(h1), .h0(h0), .m_tens(m_tens), .m_ones(m_ones), .s_tens(s_tens),.am_pm(am_pm), .s_ones(s_ones), .adv_min(btn_r), .adv_hr(btn_l));           

endmodule
