`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2022 09:02:01 PM
// Design Name: 
// Module Name: count_h
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2022 07:49:25 PM
// Design Name: 
// Module Name: count_h
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


module count_h(
       input logic clk, rst, enb,
       output logic  am_pm,
       output logic [6:0] h1, h0
        );
    
    logic enb_c;
    logic gnd;
    
    logic [4:0] q, qout;
    logic cnt_first;
    logic cy_wire;
    logic ten_over;
    logic add;
    
    logic [3:0] hundreds, tens, ones; //tens and ones digits
    
    assign gnd = 1'b0;
    
    counter_rc_mod #(.MOD(24), .W(5), .R(12), .C(1)) COUNTER(.clk(clk), .rst(rst), .enb(enb), .q(q), .cy(gnd)); //this binary counter is instantiated with 24 meaning it will assign carry and rst after it counts this sequence
    //the cy of the counter_rc_mod will be asserted when the device changes from am to pm, twelve_hr_rst must behave as a switch toggling the am/pm output in a different module
    
    assign cy_wire = (q > 5'd12) ? 1'b1 : 1'b0; //if the count is greater than 12 assert cy_wire to true, else set it to false
    assign ten_over = (q > 5'd9 && q < 5'd13 || q > 5'd21 && q < 5'd25) ? 1'b1 : 1'b0; //if q is greater than 9 the ones digit should be enabled
    assign qout = (q > 5'd12) ? q - 5'd12 : q;
    
    assign h1 = (!ten_over) ? {3'b100, tens} : {3'd0, tens}; 
    assign am_pm = (cy_wire) ? 1'b0 : 1'b1;
    
    dbl_dabble_ext BINARY_TO_BCD(.b({3'd0, qout}), .hundreds(hundreds), .tens(tens), .ones(ones)); //the binary number counted using counter_rc_mod is converted to BCD and output as digits h1 and h2 to denote the hours

    assign h0 = {7'b010, ones};


endmodule