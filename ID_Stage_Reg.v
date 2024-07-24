module ID_Stage_Reg(clk, rst, flush, SRAM_freeze, S_IN, B_IN, MEM_R_EN_IN, MEM_W_EN_IN, WB_EN_IN, imm_IN, EXE_CMD_IN,
                    Dest_IN, SR_IN, Shift_operand_IN, Signed_imm_24_IN, PC_IN, Val_Rn_IN, Val_Rm_IN, 
                    S, B, MEM_R_EN, MEM_W_EN, WB_EN, imm, EXE_CMD, Dest, SR, Shift_operand, Signed_imm_24,
                     PC, Val_Rn, Val_Rm, src1_ID, src2_ID, src1_ID_reg, src2_ID_reg);

  input clk, rst;
  input flush, SRAM_freeze, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN, imm_IN;
  input [3:0] EXE_CMD_IN, Dest_IN, SR_IN, src1_ID, src2_ID;
  input [11:0] Shift_operand_IN;
  input [23:0] Signed_imm_24_IN;
  input [31:0] Val_Rn_IN, Val_Rm_IN, PC_IN;
  
  output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm;
  output reg [3:0] EXE_CMD, Dest, SR, src1_ID_reg, src2_ID_reg;
  output reg [11:0] Shift_operand;
  output reg [23:0] Signed_imm_24;
  output reg [31:0] Val_Rn, Val_Rm, PC;
  
  always @(posedge clk, posedge rst) begin
    
    if(rst)
      {WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, EXE_CMD, Dest, Shift_operand, Signed_imm_24,
                    Val_Rn, Val_Rm, PC, SR, src1_ID_reg, src2_ID_reg} <= 158'd0;
    else if(flush)
      {WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, EXE_CMD, Dest, Shift_operand, Signed_imm_24,
                    Val_Rn, Val_Rm, PC, SR, src1_ID_reg, src2_ID_reg} <= 158'd0;
    else if(SRAM_freeze)
	{WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, EXE_CMD, Dest, Shift_operand, Signed_imm_24,
                    Val_Rn, Val_Rm, PC, SR, src1_ID_reg, src2_ID_reg} <= {WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, EXE_CMD, Dest, Shift_operand, Signed_imm_24,
                    Val_Rn, Val_Rm, PC, SR, src1_ID_reg, src2_ID_reg};
    else
      {WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, EXE_CMD, Dest, Shift_operand, Signed_imm_24,
                    Val_Rn, Val_Rm, PC, SR, src1_ID_reg, src2_ID_reg} <= { WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN, imm_IN, EXE_CMD_IN,
                    Dest_IN, Shift_operand_IN, Signed_imm_24_IN, Val_Rn_IN, Val_Rm_IN, PC_IN, SR_IN, src1_ID, src2_ID};
    
  end
  
endmodule
