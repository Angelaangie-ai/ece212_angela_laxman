`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 10:33:23 AM
// Design Name: 
// Module Name: sevenseg_ctl_tp
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


module sevenseg_ctl_tp(
input logic clk, rst,
input logic [6:0] d7,d6,d5,d4,d3,d2,d1,d0,
output logic [6:0] segs_n,
output logic dp_n,
output logic [7:0] an_n

    );
    
    logic [2:0] b;
    logic enb_out;
    logic [6:0] y;
    logic [2:0]c;
    logic clr = 1'b0;
    logic [7:0] an;
    
    period_enb #(.PERIOD_MS(1)) U_INST1 (.clk(clk), .rst(rst), .enb_out(enb_out),.clr(clr));
    counter U_INST2 (.clk(clk), .rst(rst), .enb(enb_out), .q(c));
    dec_3_8 U_INST3(.a(c), .y(an));
    mux8 U_INST4(.d0(d0),.d1(d1), .d2(d2), .d3(d3), .d4(d4),.d5(d5), .d6(d6), .d7(d7), .sel(c), .y(y));
    sevenseg_tp U_INST15(.data(y),.segs_n(segs_n), .dp_n(dp_n));
    
    assign an_n = ~an;
   
    
endmodule
