module EXE_Stage( clk, rst, S_in, B_in, mem_read_in, mem_write_in, WB_Enable_in, I, Sel_src1, Sel_src2, cmd,
 SR_in, RD_in, shifter_operand, signed_immediate, PC, reg1_in, reg2_in, S, B, mem_read,
  mem_write, WB_Enable, SR, RD, ALU_result, branch_address, reg2, ALU_result_in, WB_data);
 
    input clk, rst, S_in, B_in, mem_read_in, mem_write_in, WB_Enable_in, I;
    input [1:0] Sel_src1, Sel_src2;
    input [3:0] cmd, SR_in, RD_in;
    input [11:0] shifter_operand;
    input [23:0] signed_immediate;
    input [31:0] PC, reg1_in, reg2_in;
    input [31:0] ALU_result_in, WB_data;
    
    output S, B, mem_read, mem_write, WB_Enable;
    output [3:0] SR, RD;
    output [31:0] ALU_result, branch_address, reg2;
 
  wire [31:0] Val2, reg1;
  wire mem_read_or_write;
 
  assign S = S_in;
  
  assign B = B_in;
  
  assign branch_address = PC + ({{8{signed_immediate[23]}}, signed_immediate} << 2);
  
  assign mem_read = mem_read_in;
  
  assign mem_write = mem_write_in;
  
  assign mem_read_or_write = mem_read_in | mem_write_in;
  
  assign WB_Enable = WB_Enable_in;
  
  assign RD = RD_in;
  
  assign reg2 = (Sel_src2 == 2'b00) ? reg2_in : (Sel_src2 == 2'b01) ? ALU_result_in : (Sel_src2 == 2'b10) ? WB_data : 32'bx;
 
  Val2Generate VG2(I, mem_read_or_write, shifter_operand, reg2, Val2);

  assign reg1 = (Sel_src1 == 2'b00) ? reg1_in : (Sel_src1 == 2'b01) ? ALU_result_in : (Sel_src1 == 2'b10) ? WB_data : 32'bx;
  
  ALU A(cmd, SR_in, reg1, Val2, SR, ALU_result);
  
  
  
endmodule



