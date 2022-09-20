//-----------------------------------------------------------------------------
// Module Name   : counter_rc_mod
// Project       : RTL Hardware Design and Verification using SystemVerilog
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Jan 2022
//-----------------------------------------------------------------------------
// Description   : 4-bit counter with ripple carry and parameterized modulus
//-----------------------------------------------------------------------------

module counter_rc_mod #(parameter MOD = 4'd10,W=4,R=0,C=0) (
    input logic clk, rst, enb,
    output logic [W-1:0] q,
    output logic cy
    );


    assign cy = (q == MOD-1) && enb;

    always_ff @(posedge clk) begin
        if (rst) q <= R;
        else if (cy) q <= C;
        else if (enb) q <= q + 1;
    end

endmodule