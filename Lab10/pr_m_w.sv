module pr_m_w(input logic clk, reset,
  input logic regwrite_m, 
  input logic [1:0] memtoreg_m, 
  input logic [31:0] aluout_m, readdata_m,pcplus4_m,
  input logic [4:0] writereg_m,
  output logic regwrite_w, 
  output logic [1:0] memtoreg_w,
  output logic [31:0] aluout_w, readdata_w,pcplus4_w,
  output logic [4:0] writereg_w
  );

  always_ff @ (posedge clk)
  if (reset) begin
    regwrite_w <= 0;
    memtoreg_w <= 0;
    aluout_w <= '0;
    readdata_w <= '0;
    writereg_w <= '0;
    pcplus4_w <= '0;
  end
  else begin
    regwrite_w <= regwrite_m;
    memtoreg_w <= memtoreg_m;
    aluout_w <= aluout_m;
    readdata_w <= readdata_m;
    writereg_w <= writereg_m;
    pcplus4_w <= pcplus4_m;
  end
endmodule: pr_m_w
