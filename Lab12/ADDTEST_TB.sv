`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2022 09:18:43 AM
// Design Name: 
// Module Name: OG_TB
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


module ADDTEST_TB();

    logic        clk;
    logic        reset;

    logic [31:0] writedata, dataadr;
    logic        memwrite;

    // instantiate device to be tested
    top2 DUV(.clk, .reset, .writedata, .dataadr, .memwrite);

    // initialize test
    initial
    begin
        reset <= 1; # 12; reset <= 0;
    end

    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

    // check that 7 gets written to address 84
    always@(negedge clk)
    begin
        if(memwrite) begin
            if(dataadr === 84 & writedata === 7) begin
                $display("Original Simulation Succeeded");
                @(posedge clk);
                $stop;
            end else if (dataadr !== 80) begin
                $display("Simulation failed - expected to write m[84]=7, actual value %d",writedata);
                @(posedge clk);
                $stop;
            end
        end
    end

    localparam LIMIT = 42;  // don't let simulation go on forever

    integer cycle = 0;

    always @(posedge clk)
    begin
        if (cycle>LIMIT) $stop;
        else cycle <= cycle + 1;
    end
endmodule
