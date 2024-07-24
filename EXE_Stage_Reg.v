module EXE_Stage_Reg(clk, rst, SRAM_freeze, mem_read_in, mem_write_in, WB_Enable_in, RD_in, reg2_in,
                     ALU_result_in, mem_read, mem_write, WB_Enable, RD, reg2, ALU_result);

    input clk, rst, SRAM_freeze, mem_read_in, mem_write_in, WB_Enable_in;
    input [3:0] RD_in;
    input [31:0] reg2_in, ALU_result_in;
    
    output reg mem_read, mem_write, WB_Enable;
    output reg [3:0] RD;
    output reg [31:0] reg2, ALU_result;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            mem_write = 1'b0;
            mem_read = 1'b0;
            WB_Enable = 1'b0;
            RD = 4'b0;
            reg2 = 32'b0;
            ALU_result = 32'b0;
        end
	else if (SRAM_freeze)begin
	    mem_write = mem_write;
            mem_read = mem_read;
            WB_Enable = WB_Enable;
            RD = RD;
            reg2 = reg2;
            ALU_result = ALU_result;
	end
        else begin
            mem_write = mem_write_in;
            mem_read = mem_read_in;
            WB_Enable = WB_Enable_in;
            RD = RD_in;
            reg2 = reg2_in;
            ALU_result = ALU_result_in;
        end
    end

endmodule



