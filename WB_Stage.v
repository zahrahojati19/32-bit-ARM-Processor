module WB_Stage(clk, rst, mem_read, WB_Enable_in, RD_in, ALU_result_in,
                mem_read_data_in, WB_Enable, RD, WB_data);

    input clk, rst, mem_read, WB_Enable_in;
    input [3:0] RD_in;
    input [31:0] ALU_result_in, mem_read_data_in;
    
    output WB_Enable;
    output [3:0] RD;
    output [31:0] WB_data;
    
    assign RD = RD_in;
    
    assign WB_Enable = WB_Enable_in;
    
    assign WB_data = (mem_read)? mem_read_data_in:ALU_result_in;

endmodule



