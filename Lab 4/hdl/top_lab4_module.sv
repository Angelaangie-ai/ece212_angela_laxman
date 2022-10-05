`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2022 08:42:17 AM
// Design Name: 
// Module Name: top_lab4_module
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


module top_lab4_module(

    input logic clk, btn_d, btn_l, btn_r, rst, tc_enb,
    input logic [1:0] in,
     input logic [12:0] sw_test, 
     output logic [6:0] segs_n,
     output logic [7:0] an_n,
     output logic dp_n,
     inout tmp_scl,
     inout tmp_sda
    );
    
    logic enb_out;
    logic [6:0] segs_n_1;
    logic [6:0] segs_n_2;
    logic [7:0] an_n_1;
    logic [7:0] an_n_2;
    logic dp_n_1;
    logic dp_n_2;
    logic dsel;
    logic c_f;
    logic [7:0] an;
    logic clr;

    assign clr = 0;
    
    top_module U_1 (.clk(clk), .btn_d(btn_d), .btn_l(btn_l), .btn_r(btn_r), .an_n(an_n_1), .segs_n(segs_n_1), .dp_n(dp_n_1));
    lab03_top U_2 (.clk(clk), .rst(rst), .tc_enb(tc_enb), .c_f(c_f), .sw_test(sw_test), .an_n(an_n_2), .segs_n(segs_n_2), .dp_n(dp_n_2), .tmp_scl(tmp_scl), .tmp_sda(tmp_sda));
    period_enb #(.PERIOD_MS(2000)) U_3 (.clk(clk), .rst(rst), .enb_out(enb_out),.clr(clr));
    fsm U_4 (.clk(clk), .rst(rst), .enb2s(enb_out), .dsel(dsel), .in(in), .c_f(c_f));
    mux2 #(.W(7)) U_5 (.sel(dsel), .d0(segs_n_1), .d1(segs_n_2), .y(segs_n));
    mux2 #(.W(8)) U_6  (.sel(dsel), .d0(an_n_1), .d1(an_n_2), .y(an_n));
    mux2 #(.W(1))U_7 (.sel(dsel), .d0(dp_n_1), .d1(dp_n_2), .y(dp_n));
    
   

    
   
   
endmodule
