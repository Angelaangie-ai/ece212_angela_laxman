`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2022 08:39:33 PM
// Design Name: 
// Module Name: dig_clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Crea ted
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dig_clock(input logic clk,rst,adv_min,adv_hr,
                 output logic [6:0] h1,h0,m_tens,m_ones,s_tens,s_ones,am_pm);
                 
                 logic enb1;
                 logic enb2;
                 logic enb3;
                 logic clr = 1'd0;
                 logic cy1, cy2;
                 logic m,l;
                 logic am_pm_b;
                 
                 
                 assign  m = adv_min & enb1;
                 assign  enb2 = m | cy1;
                 
                 assign l = adv_hr & enb1;
                 assign enb3 = l | cy2;
    period_enb #(.PERIOD_MS(1000)) U_PEBB(.clk(clk), .rst(rst), .enb_out(enb1),.clr(clr));
    count_s U_INST6(.clk(clk), .rst(rst), .enb(enb1), .s_tens(s_tens), .s_ones(s_ones), .cy(cy1));
    count_m U_INST7(.clk(clk), .rst(rst), .enb(enb2),.adv_min(adv_min), .m_tens(m_tens), .m_ones(m_ones), .cy(cy2));
    count_h U_INST8(.clk(clk), .rst(rst), .enb(enb3), .h1(h1), .h0(h0), .am_pm(am_pm_b));

    always_comb begin
        if (am_pm_b) am_pm <=7'd11;
        else am_pm <= 7'd10;
   end
    
    
    
endmodule
