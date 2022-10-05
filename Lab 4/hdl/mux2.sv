module mux2 #(parameter W=7)
             (input logic [W-1:0]  d0, d1,
              input logic          sel,
              output logic [W-1:0] y );

   always_comb
     if (sel) y = d1;
     else y = d0;

endmodule: mux2