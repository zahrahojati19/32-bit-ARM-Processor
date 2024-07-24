module IF_Stage_Reg (clk, rst, freeze, SRAM_freeze, flush, PC_in, Insruction_in, PC, Insruction);
  
  input clk, rst, freeze, SRAM_freeze, flush;
  
  input [31:0] PC_in, Insruction_in;
  
  output reg [31:0] PC, Insruction;
  
  always @(posedge clk, posedge rst) begin
    
    if (rst) begin
      PC <= 0;
      Insruction <= 0;
    end
    else if(flush) begin
      PC <= 0;
      Insruction <= 0;
    end
    else if(freeze | SRAM_freeze) begin
      PC <= PC;
      Insruction <= Insruction;
    end
    else begin
      PC <= PC_in;
      Insruction <= Insruction_in;
    end
      
  end

endmodule

