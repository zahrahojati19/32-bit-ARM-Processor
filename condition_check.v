module Condition_Check(SR, cond, flag);
  
  input [3:0] cond;
  input [3:0] SR;
  
  output reg flag;
  
  always @(cond, SR) begin
    case(cond) 
      4'b0000: flag = (SR[2] == 1'b1) ? 1'b1 : 1'b0;
      4'b0001: flag = (SR[2] == 1'b0) ? 1'b1 : 1'b0;
      4'b0010: flag = (SR[1] == 1'b1) ? 1'b1 : 1'b0;
      4'b0011: flag = (SR[1] == 1'b0) ? 1'b1 : 1'b0;
      4'b0100: flag = (SR[3] == 1'b1) ? 1'b1 : 1'b0;
      4'b0101: flag = (SR[3] == 1'b0) ? 1'b1 : 1'b0;
      4'b0110: flag = (SR[0] == 1'b1) ? 1'b1 : 1'b0;
      4'b0111: flag = (SR[0] == 1'b0) ? 1'b1 : 1'b0;
      4'b1000: flag = (SR[1] == 1'b1 && SR[2] == 1'b0) ? 1'b1 : 1'b0;
      4'b1001: flag = (SR[1] == 1'b0 && SR[2] == 1'b1) ? 1'b1 : 1'b0;
      4'b1010: flag = (SR[0] == SR[3]) ? 1'b1 : 1'b0;
      4'b1011: flag = (SR[0] != SR[3]) ? 1'b1 : 1'b0;
      4'b1100: flag = (SR[0] == SR[3] && SR[2] == 1'b0 ) ? 1'b1 : 1'b0;
      4'b1101: flag = (SR[0] != SR[3] || SR[2] == 1'b1) ? 1'b1 : 1'b0;
      4'b1110: flag = 1'b1;
      default: flag = 1'b0;       
    endcase
  end
  
endmodule

