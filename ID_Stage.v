module ID_Stage( clk, rst, writeBackEn, hazard, Dest_wb, SR, instruction, PC_in, Result_WB,
                 S, B, mem_read, mem_write, WB_Enable, I, two_src, move, cmd, src1, src2, Dest,
                shifter_operand, signed_immediate, PC, reg1, reg2);
                
    input clk, rst, writeBackEn, hazard;
    input [3:0] Dest_wb, SR;
    input [31:0] instruction, PC_in, Result_WB;
    
    output S, B, mem_read, mem_write, WB_Enable, I, two_src, move;
    output [3:0] cmd, src1, src2, Dest;
    output [11:0] shifter_operand;
    output [23:0] signed_immediate;
    output [31:0] PC, reg1, reg2; //n,m
 
    wire S_C, B_C, mem_write_C, mem_read_C, WB_Enable_C, condition;
    wire[3:0] cmd_C, Rm;
    
    
    assign PC = PC_in;
    
    assign I = instruction[25];
    
    assign src1 = instruction[19:16];
    
    assign Dest = instruction[15:12];
    
    assign Rm = instruction[3:0];
    
    assign src2 = (mem_write)? instruction[15:12]:instruction[3:0];
    
    assign signed_immediate = instruction[23:0];
    
    assign shifter_operand = instruction[11:0];
    
    assign {S, B, mem_write, mem_read, WB_Enable, cmd} = (~condition | hazard)? 9'b0:{S_C, B_C, mem_write_C, mem_read_C, WB_Enable_C, cmd_C};
    
    assign two_src = ((~I) & (instruction[27:26] == 2'b0)) | mem_write;
    
    Control_Unit CU( instruction[20], instruction[27:26], instruction[24:21], S_C, B_C, mem_write_C, mem_read_C, WB_Enable_C, move, cmd_C);
    
    Condition_Check CC( SR, instruction[31:28], condition);
    
    RegisterFile RF(clk, rst, writeBackEn, src1, src2, Dest_wb, Result_WB, reg1, reg2 );
  
endmodule
