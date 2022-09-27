`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 10:04:24 AM
// Design Name: 
// Module Name: tconvert
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


module tconvert( input logic signed[12:0] tc, 
                 input logic c_f,
                 output logic signed [17:0] tx10); //would the sign take another bit?
                 
      logic [16:0] temp_cel_wire;
      logic [17:0] fah_wire, w0, cel_wire;
     
      
      assign temp_cel_wire = (tc << 3) + (tc << 1);  //multiply the celsius temperature by 10
     
      assign fah_wire = (tc << 4) + (tc << 1);  //multiply the fahrenheit temperature by 18 and add 320
      
      assign w0 = fah_wire + {14'd320, 4'b0000};  //convert to Fahrenheit
      
     always_comb begin
     if (temp_cel_wire[16] == 1) cel_wire = {temp_cel_wire[16], 1'b1, temp_cel_wire[15:0]};
     else cel_wire = {temp_cel_wire[16], 1'b0, temp_cel_wire[15:0]};
     end
     
      assign tx10 = (c_f) ? w0 : cel_wire; //if c_f is high, output the fahrenheit conversion, else celsius

 
endmodule
