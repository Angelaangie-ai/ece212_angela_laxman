`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 10:13:26 AM
// Design Name: 
// Module Name: lab03_top
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


module lab03_top(
 input logic clk, rst, tc_enb, c_f,
 input logic [12:0] sw_test,
 output logic [7:0] an_n,
 output logic [6:0] segs_n,
 output logic dp_n,
 inout tmp_scl, // use inout only – no logic
 inout tmp_sda // use inout only – no logic
 );
 
     logic [3:0] thousands, hundreds, tens, ones;
     logic sign;
     logic [6:0] minus, thousands_wire, blank;
     logic tmp_rdy, tmp_err; // unused temp controller outputs
 // 13-bit two's complement result with 4-bit fractional part
     logic signed [12:0] temp, temp_wire;

 
 // instantiate the VHDL temperature sensor controller
 TempSensorCtl U_TSCTL (
 .TMP_SCL(tmp_scl), .TMP_SDA(tmp_sda), .TEMP_O(temp),
 .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk100MHz),
 .SRST_I(rst) 
 );
 
        assign temp_wire = (tc_enb) ? sw_test : temp;

        tdisplay U_DISPLAY (.tc(temp_wire), .c_f, .thousands, .hundreds, .tens, .ones, .sign);
        
        assign minus = (sign) ? 7'b0010000 : 7'b1000000;
        assign thousands_wire = (thousands == 4'd0) ? minus : {3'b000,thousands};
        assign blank = (thousands_wire != minus) ? minus : 7'b1000000;
        sevenseg_ctl U_SEVEN_SEG (.clk, .rst, .d7(7'b1000000), .d6(7'b1000000), .d5(blank), .d4(thousands_wire), .d3({3'b000,hundreds}), .d2({3'b010,tens}), .d1({3'b000,ones}), .d0(7'b0001010 + c_f), .segs_n, .dp_n, .an_n);

endmodule
