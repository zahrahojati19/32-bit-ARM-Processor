`timescale 1ns/1ns
module TB;
  
  reg clk = 0, rst = 1, fu = 1;
  wire [15:0] SRAM_DQ;
  wire [17:0] SRAM_ADDR;
  wire SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;

    always #5 clk=~clk;

    ARM UUT(clk, rst, fu);//, SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);

    initial begin
        
        #12
        rst = 0;
        repeat(300) @(posedge clk);
        $stop();
    end
endmodule
