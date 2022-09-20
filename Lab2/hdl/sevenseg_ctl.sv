`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2022 08:56:51 AM
// Design Name: 
// Module Name: sevenseg_ctl
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


module sevenseg_ctl(
input logic clk, rst,
input logic [6:0] d7,d6,d5,d4,d3,d2,d1,d0,
output logic [6:0] segs_n,
output logic dp_n,
output logic [7:0] an_n

    );
    
    logic [2:0] b;
    logic [2:0] enb_out;
    logic [6:0] y;
    
    period_enb U_INST1 (.clk(clk), .rst(rst), .enb_out(enb_out));
    counter U_INST2 (.clk(clk), .rst(rst), .enb(enb_out), .q(q));
    dec_3_8 U_INST3(.a(q), .y(an_n));
    mux8 U_INST4(.d0(d0),.d1(d1), .d2(d2), .d3(d3), .d4(d4),.d5(d5), .d6(d6), .d7(d7), .sel(q), .y(y));
    sevenseg_ext_n U_INST5(.data(b),.segs_n(segs_n));
   
    
endmodule
