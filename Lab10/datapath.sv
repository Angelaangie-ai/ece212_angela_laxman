module datapath(input  logic        clk, reset,
  input logic [1:0]   memtoreg_d,
  input logic         memwrite_d, pcsrc_d, alusrc_d,
  input logic         branch_d,
  input logic [1:0]   regdst_d,
  input logic regwrite_d, jump_d, jump_r_d,
  input logic [2:0]   alucontrol_d,
  output logic        zero_d,
  output logic [31:0] pc_f,
  input logic [31:0]  instr_f,
  output logic [31:0] instr_d,
  output logic memwrite_m,
  output logic [31:0] aluout_m,
  output logic [31:0] writedata_m,
  input logic [31:0]  readdata_m);


  //--------------------------------------------------------------
  //   Signal Declarations
  //--------------------------------------------------------------
  //   IF Declarations

  logic [31:0]                     pcplus4_f, pcnextbr_f, pcnext_f, pcnext_j;
  // instr_f already declared as an input port

  //   ID Declarataions (not control signals are module inputs)
  
  logic [4:0]                      rs_d;
  logic [4:0]                      rt_d;
  logic [4:0]                      rd_d;
  logic [15:0]                     immed_d;  // i-type immediate field
  logic [25:0]                     jpadr_d;  // j-type pseudo-address
  logic [31:0]                     pcnextbr_d, pcplus4_d, pcplus4_e, pcplus4_m, pcplus4_w, pcbranch_d;
  logic [31:0]                     rd1_d, rd2_d;
  logic [31:0]                     signimm_d, signimmsh_d;
  logic [31:0]                     pcjump_d;

  // EX Declarataions
  
  logic         memwrite_e, alusrc_e;
  logic         regwrite_e;
  logic [2:0]   alucontrol_e;
  logic [1:0]   regdst_e, memtoreg_e;

  logic [4:0]                      rs_e;
  logic [4:0]                      rt_e;
  logic [4:0]                      rd_e;
  logic [4:0]                      writereg_e;
  logic signed [31:0]              srca_e, srcb_e;
  logic [31:0]                     rd1_e, rd2_e;
  logic [31:0]                     signimm_e;
  logic [31:0]                     aluout_e;
  logic [31:0]                     writedata_e;
  logic                            zero_e; // unused ALU port

  // MEM Declarataions

  logic                            regwrite_m;
  logic [1:0]                      memtoreg_m;
  logic [4:0]                      writereg_m;  // WB Declarations

  // WB Declarataions

  logic                            regwrite_w;
  logic [1:0]                      memtoreg_w;
  logic [4:0]                      writereg_w, jr_mux_out;
  logic [31:0]                     readdata_w, aluout_w, result_w;
  
  
  
  

  //--------------------------------------------------------------
  //   Hazard Unit
  //--------------------------------------------------------------

logic [1:0] forward_ae, forward_be;
logic forward_ad, forward_bd;
logic stall_f, stall_d, flush_e;
logic [31:0] fmux_d1, fmux_d2;

hazard_unit U_HAZARD(.memtoreg_e, .regwrite_e, .regwrite_m, .regwrite_w, .branch_d, .writereg_e, .writereg_m, .writereg_w, 
                    .rs_e, .rs_d, .rt_e, .rt_d,
                    .forward_ae, .forward_be, .forward_ad, .forward_bd, 
                    .stall_f, .stall_d, .flush_e);

  //--------------------------------------------------------------
  //   IF Stage
  //--------------------------------------------------------------
  
  pr_pc U_PC_F(.clk, .reset, .stall_f, .pcnext_f, .pc_f);

  adder U_PCADD_F(.a(pc_f), .b(32'h4), .y(pcplus4_f));

  mux2 #(32) U_PCBRMUX_F(.d0(pcplus4_f), .d1(pcbranch_d), .s(pcsrc_d), .y(pcnextbr_f));

  mux2 #(32)  U_PCJMUX_F(.d0(pcnextbr_f), .d1(pcjump_d), .s(jump_d), .y(pcnext_j));
  
  //rd1_d, address of rs will be used as PC'
  //control signal rd1_d
  mux2 #(32)  U_PCJMUX_J(.d0(pcnext_j), .d1(rd1_d), .s(jump_r_d), .y(pcnext_f));


  //--------------------------------------------------------------
  //   ID Stage (note control signals arrive here)
  //--------------------------------------------------------------

  pr_f_d U_PR_F_D(.clk, .reset, .stall_d,
                  .instr_f, .pcplus4_f,
                  .instr_d, .pcplus4_d);

  assign rs_d = instr_d[25:21];
  assign rt_d = instr_d[20:16];
  assign rd_d = instr_d[15:11];
  assign immed_d = instr_d[15:0];
  assign jpadr_d = instr_d[25:0];

  assign pcjump_d = { pcplus4_d[31:28], jpadr_d, 2'b00 };  // jump target address

    
  mux2 #(32)  U_REG31MUX_JR(.d0(rs_d), .d1(5'd31), .s(jump_r_d), .y(jr_mux_out));  

  regfile     U_RF_D(.clk(clk), .we3(regwrite_w), .ra1(jr_mux_out), .ra2(rt_d),
                     .wa3(writereg_w), .wd3(result_w),
                     .rd1(rd1_d), .rd2(rd2_d));

  // add forwarding muxes for comparator later
  mux2 #(32) U_FORWARD_MUX_1_D(.d0(rd1_d), .d1(aluout_m), .s(forward_ad), .y(fmux_d1));

  mux2 #(32) U_FORWARD_MUX_2_D(.d0(rd2_d), .d1(aluout_m), .s(forward_bd), .y(fmux_d2));
  
  
  assign zero_d = (fmux_d1 == fmux_d2);

  signext     U_SE_D(.a(immed_d), .y(signimm_d));

  sl2         U_IMMSH_D(.a(signimm_d), .y(signimmsh_d));

  adder       U_PCADD_D(.a(pcplus4_d), .b(signimmsh_d), .y(pcbranch_d));

  //--------------------------------------------------------------
  //   EX Stage
  //--------------------------------------------------------------

  pr_d_e U_PR_D_E(.clk, .reset, .flush_e,
                  .regwrite_d, .memtoreg_d, .memwrite_d, .alucontrol_d,
                  .alusrc_d, .regdst_d, .rd1_d, .rd2_d,
                  .rs_d, .rt_d, .rd_d, .signimm_d, .pcplus4_d,
                  .regwrite_e, .memtoreg_e, .memwrite_e, .alucontrol_e,
                  .alusrc_e, .regdst_e, .rd1_e, .rd2_e,
                  .rs_e, .rt_e, .rd_e, .signimm_e, .pcplus4_e);

  // add forwarding muxes here

  
   mux3 #(32)   U_FORWARD_MUX_1_E(.d0(rd1_e), .d1(result_w), .d2(aluout_m), .s(forward_ae), .y(srca_e));
   
   mux3 #(32)   U_FORWARD_MUX_2_E(.d0(rd2_e), .d1(result_w), .d2(aluout_m), .s(forward_be), .y(writedata_e));
  


                  // ALU logic
  mux2 #(32)  U_SRCBMUX(.d0(writedata_e), .d1(signimm_e), .s(alusrc_e), .y(srcb_e));

  alu U_ALU(.a(srca_e), .b(srcb_e), .f(alucontrol_e),
                  .y(aluout_e), .zero(zero_e));

  mux3 #(5)   U_WRMUX(.d0(rt_e), .d1(rd_e), .d2(5'd31), .s(regdst_e), .y(writereg_e));

  //--------------------------------------------------------------
  //   MEM Stage
  //--------------------------------------------------------------

  pr_e_m U_PR_E_M(.clk, .reset,
         .regwrite_e, .memtoreg_e, .memwrite_e,
         .aluout_e, .writedata_e, .writereg_e, .pcplus4_e,
         .regwrite_m, .memtoreg_m, .memwrite_m,
         .aluout_m, .writedata_m, .writereg_m, .pcplus4_m);

  // memory connected through i/o ports

  //--------------------------------------------------------------
  //   WB Stage
  //--------------------------------------------------------------

  pr_m_w U_PR_M_W(.clk, .reset,
        .regwrite_m, .memtoreg_m, .aluout_m, .readdata_m, .writereg_m, .pcplus4_m,
        .regwrite_w, .memtoreg_w, .aluout_w, .readdata_w, .writereg_w, .pcplus4_w);

    mux3 #(32)  U_RESMUX(.d0(aluout_w), .d1(readdata_w), .d2(pcplus4_w), .s(memtoreg_w), .y(result_w));

endmodule
