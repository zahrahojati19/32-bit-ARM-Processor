module MEM_Stage_Reg(clk, rst, SRAM_freeze, mem_read_in, WB_Enable_in, RD_in, mem_read_data_in,
                     ALU_result_in, mem_read, WB_Enable, RD, mem_read_data, ALU_result);
 
  input clk, rst, SRAM_freeze;
  input mem_read_in, WB_Enable_in;
  input[3:0] RD_in;
  input[31:0] mem_read_data_in, ALU_result_in;
  
  output reg mem_read, WB_Enable;
  output reg[3:0] RD;
  output reg[31:0] mem_read_data, ALU_result;
  
  always @(posedge clk, posedge rst) begin
    if (rst) begin
        mem_read = 1'b0;
        WB_Enable = 1'b0;
        RD = 4'b0;
        mem_read_data = 32'b0;
        ALU_result = 32'b0;
    end
    else if (SRAM_freeze) begin
	mem_read = mem_read;
        WB_Enable = WB_Enable;
        RD = RD;
        mem_read_data = mem_read_data;
        ALU_result = ALU_result;
    end
    else begin
        mem_read = mem_read_in;
        WB_Enable = WB_Enable_in;
        RD = RD_in;
        mem_read_data = mem_read_data_in;
        ALU_result = ALU_result_in;
    end
  end
  
endmodule

