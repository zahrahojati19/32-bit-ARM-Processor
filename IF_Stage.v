module IF_Stage (clk, rst, freeze, SRAM_freeze, Branch_taken, BranchAddr, PC, Instruction);
  
  input clk, rst, freeze, SRAM_freeze, Branch_taken;
  input [31:0] BranchAddr;
  
  output [31:0] PC, Instruction;
  
  wire [31:0] pc_in;
  
  reg [31:0] pc_out;
  
  assign pc_in = (Branch_taken) ? BranchAddr : PC;
  
  always @(posedge clk, posedge rst) begin
    if(rst)
      pc_out <= 0;
    else if(freeze | SRAM_freeze)
      pc_out <= pc_out;
    else
      pc_out <= pc_in;
  end
  
  assign PC = pc_out + 32'd4;
  
  Instruction_Memory InstMem(pc_out, Instruction);
  
endmodule


