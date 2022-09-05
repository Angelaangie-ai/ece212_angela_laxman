`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2022 08:56:49 AM
// Design Name: 
// Module Name: sevenseg_ext_tb
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


module sevenseg_ext_tb;
    logic [6:0] data;
    logic [6:0] segs_n;
    logic dp_n;
    
    sevenseg_ext_n DUV(.data, .segs_n, .dp_n);
    
    initial begin
        data[6] = 1;
        segs_n = 0;
        dp_n = 0;
        #10;
        data [6] = 0;
        data [5] = 1;
        segs_n = 0;
        dp_n = 0;
        #10;
        data [6] =0;
        data [4] =1;
        segs_n = 0;
        dp_n = 0;
        #10;
        data[6] = 0;
        data [4] = 0;
        data [3] = 1;
        segs_n = 0;
        dp_n = 1;
        #10;   
        data[6] = 0;
        data [4] = 0;
        data [2] = 1;
        segs_n = 0;
        dp_n = 1;
        #10;   
    end
endmodule