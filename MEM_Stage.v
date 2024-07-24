module MEM_Stage(clk, rst, mem_read_in, mem_write_in, WB_Enable_in, RD_in, reg2_in, 
                 ALU_result_in,  mem_read, WB_Enable, RD, mem_read_data, ALU_result, 
		SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N, SRAM_freeze);
 
    input clk, rst;
    input mem_read_in, mem_write_in, WB_Enable_in;
    input[3:0] RD_in;
    input[31:0] reg2_in, ALU_result_in;
  
    output  mem_read, WB_Enable;
    output [3:0] RD;
    output [31:0] mem_read_data, ALU_result;
    output [15:0] SRAM_DQ;
    output [17:0] SRAM_ADDR;
    output SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N, SRAM_freeze;
  
    assign RD = RD_in;
    assign ALU_result = ALU_result_in;
    assign mem_read = mem_read_in;
    assign WB_Enable = WB_Enable_in;
    
    wire ready;
    wire [31:0] aligned_address;

    /*assign aligned_address = (ALU_result_in - 32'd1024);
    assign SRAM_freeze = ~ready;
    SRAM_Controller SRAM(clk, rst, mem_write_in, mem_read_in, aligned_address, reg2_in, mem_read_data, ready, SRAM_DQ, SRAM_ADDR, 
			 SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);*/
	
    reg [31:0] mem [63:0]; //64k Word or 256k Byte
    assign aligned_address = (ALU_result_in - 32'd1024) >> 2;
    assign mem_read_data = (mem_read_in)? mem[aligned_address]:32'bz;

    always @(posedge clk) begin
        if (mem_write_in)
            mem[aligned_address] = reg2_in;
    end
endmodule



