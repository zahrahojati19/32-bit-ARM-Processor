module RegisterFile (clk, rst, WriteBackEn, src1, src2, Dest_wb, Result_WB, reg1, reg2);
  
  input clk, rst;
  input WriteBackEn;
  input [3:0] src1, src2, Dest_wb;
  input [31:0] Result_WB;
  
  output [31:0] reg1, reg2;
  
  reg [31:0]RF[0:14];
  
  integer i;
  
  always @(negedge clk, posedge rst) begin
    
    if(rst) begin
      for( i = 0; i<15; i = i + 1)begin
        RF[i] = i;
      end
    end
    if(WriteBackEn) begin
      RF[Dest_wb] = Result_WB;
    end
  end
  
  assign reg1 = RF[src1];
  
  assign reg2 = RF[src2];
  
endmodule