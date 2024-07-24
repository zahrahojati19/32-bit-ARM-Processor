module ARM(
    clk, rst, fu//, SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
);
    input clk, rst, fu;
    wire [15:0] SRAM_DQ;
    wire [17:0] SRAM_ADDR;
    wire SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N, SRAM_freeza;

    wire[31:0] PC, instruction, PC_IF_Reg, instruction_IF_Reg,
    PC_ID, PC_ID_Reg, reg1_ID, reg2_ID, reg1_ID_Reg, reg2_ID_Reg,
    ALU_result_EXE, branch_address, reg2_EXE,
    reg2_EXE_Reg, ALU_result_EXE_Reg,
    ALU_result_MEM, mem_read_data_MEM, 
    mem_read_data_MEM_Reg, ALU_result_MEM_Reg,
    WB_data;
    
    wire[23:0] ssigned_immediate_ID, ssigned_immediate_ID_Reg;
    
    wire[11:0] shifter_operand_ID, shifter_operand_ID_Reg;
        
    wire S_ID, B_ID, mem_read_ID, mem_write_ID, WB_Enable_ID, two_src_ID, move_ID,
     S_ID_Reg, B_ID_Reg, mem_read_ID_Reg, mem_write_ID_Reg, WB_Enable_ID_Reg,
     S_EXE, B_EXE, mem_read_EXE, mem_write_EXE, WB_Enable_EXE,
     mem_read_EXE_Reg, mem_write_EXE_Reg, WB_Enable_EXE_Reg,
     mem_read_MEM, WB_Enable_MEM,
     mem_read_MEM_Reg, WB_Enable_MEM_Reg,
     WB_Enable_WB,
     hazard, SRAM_freeze;
    
    wire [3:0] cmd_ID, src1_ID, src2_ID, src1_ID_reg, src2_ID_reg, RD_ID,
    cmd_ID_Reg, RD_ID_Reg, SR_ID_Reg,
    SR_EXE, RD_EXE,
    RD_EXE_Reg,
    RD_MEM,
    RD_MEM_Reg,
    RD_WB,
    SR;
    
    wire [1:0] Sel_src1, Sel_src2;


    IF_Stage IF(clk, rst, hazard, SRAM_freeze, B_EXE, branch_address, PC, instruction );
    
    IF_Stage_Reg IF_Reg(clk, rst, hazard, SRAM_freeze, B_EXE, PC, instruction, PC_IF_Reg, instruction_IF_Reg);
    
    ID_Stage ID(clk, rst, WB_Enable_WB, hazard, RD_WB, SR, instruction_IF_Reg, PC_IF_Reg, WB_data,
     S_ID, B_ID, mem_read_ID, mem_write_ID, WB_Enable_ID, I_ID, two_src_ID, move_ID, cmd_ID, src1_ID, src2_ID, RD_ID,
     shifter_operand_ID, ssigned_immediate_ID, PC_ID, reg1_ID, reg2_ID);
    
    ID_Stage_Reg ID_Reg(clk, rst, SRAM_freeze, B_EXE, S_ID, B_ID, mem_read_ID, mem_write_ID, WB_Enable_ID, 
    I_ID ,cmd_ID, RD_ID, SR, shifter_operand_ID, ssigned_immediate_ID, PC_ID, reg1_ID, reg2_ID, S_ID_Reg, B_ID_Reg, mem_read_ID_Reg, mem_write_ID_Reg, WB_Enable_ID_Reg,
    I_ID_Reg ,cmd_ID_Reg, RD_ID_Reg, SR_ID_Reg, shifter_operand_ID_Reg, ssigned_immediate_ID_Reg, PC_ID_Reg, reg1_ID_Reg, reg2_ID_Reg, src1_ID, src2_ID, src1_ID_reg, src2_ID_reg);
        
    EXE_Stage EXE(clk, rst, S_ID_Reg, B_ID_Reg, mem_read_ID_Reg, mem_write_ID_Reg, WB_Enable_ID_Reg, I_ID_Reg, Sel_src1, Sel_src2,
    cmd_ID_Reg, SR_ID_Reg, RD_ID_Reg, shifter_operand_ID_Reg, ssigned_immediate_ID_Reg,PC_ID_Reg, reg1_ID_Reg, reg2_ID_Reg,
    S_EXE, B_EXE, mem_read_EXE, mem_write_EXE, WB_Enable_EXE, SR_EXE, RD_EXE, ALU_result_EXE, branch_address, reg2_EXE, ALU_result_MEM, WB_data);
    
    EXE_Stage_Reg EXE_Reg(clk, rst, SRAM_freeze, mem_read_EXE, mem_write_EXE, WB_Enable_EXE, RD_EXE, reg2_EXE, ALU_result_EXE,
    mem_read_EXE_Reg, mem_write_EXE_Reg, WB_Enable_EXE_Reg, RD_EXE_Reg, reg2_EXE_Reg, ALU_result_EXE_Reg);
    
    MEM_Stage MEM(clk, rst, mem_read_EXE_Reg, mem_write_EXE_Reg, WB_Enable_EXE_Reg, RD_EXE_Reg, reg2_EXE_Reg, ALU_result_EXE_Reg,
    mem_read_MEM, WB_Enable_MEM, RD_MEM, mem_read_data_MEM, ALU_result_MEM,
    SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N, SRAM_freeze);
    
    MEM_Stage_Reg MEM_Reg(clk, rst, SRAM_freeze, mem_read_MEM, WB_Enable_MEM, RD_MEM, mem_read_data_MEM, ALU_result_MEM,
    mem_read_MEM_Reg, WB_Enable_MEM_Reg, RD_MEM_Reg, mem_read_data_MEM_Reg, ALU_result_MEM_Reg);
    
    WB_Stage WB(clk, rst, mem_read_MEM_Reg, WB_Enable_MEM_Reg, RD_MEM_Reg, ALU_result_MEM_Reg, mem_read_data_MEM_Reg,
    WB_Enable_WB, RD_WB, WB_data);
    
    status_register SReg(clk, rst, S_ID_Reg, SR_EXE, SR);
    
    hazard_unit HU(fu, mem_read_EXE, two_src_ID, move_ID, WB_Enable_MEM, WB_Enable_EXE,
    RD_MEM, RD_EXE, src1_ID, src2_ID, hazard);

    Forwarding_Unit FU(fu, src1_ID_reg, src2_ID_reg, WB_Enable_MEM, WB_Enable_WB, RD_MEM, RD_WB, Sel_src1, Sel_src2);

    //SRAM sram(clk, rst, SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);
    
endmodule
