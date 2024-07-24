// AND 0
// EOR 1
// SUB 2
// ADD 4
// ADC 5
// SBC 6
// TST 8
// CMP 10
// ORR 12
// MOV 13
// MVN 15
// LDR 4
// STR 4

module Control_Unit(S, mode, Opcode, Stat_update, B, mem_write, mem_read, WB_Enable, move, Execute_Command);
  
  input S;
  input [1:0] mode;
  input [3:0] Opcode;
  
  output reg mem_read, mem_write, WB_Enable, B, Stat_update, move;
  output reg [3:0] Execute_Command;
  
  always@(mode, Opcode, S)begin
    {mem_read, mem_write, WB_Enable, B, Stat_update, Execute_Command,move} = 10'd0;
    case(mode)
      0 : begin
           Stat_update = S;
           case(Opcode)
            0  : {Execute_Command, WB_Enable} = {4'b0110, 1'b1};
            1  : {Execute_Command, WB_Enable} = {4'b1000, 1'b1};
            2  : {Execute_Command, WB_Enable} = {4'b0100, 1'b1};
            4  : {Execute_Command, WB_Enable} = {4'b0010, 1'b1};
            5  : {Execute_Command, WB_Enable} = {4'b0011, 1'b1};
            6  : {Execute_Command, WB_Enable} = {4'b0101, 1'b1};
            8  : {Execute_Command} = {4'b0110}; // ?
            10 : {Execute_Command} = {4'b0100}; // ?
            12 : {Execute_Command, WB_Enable} = {4'b0111, 1'b1};
            13 : {Execute_Command, WB_Enable, move} = {4'b0001, 1'b1, 1'b1};
            15 : {Execute_Command, WB_Enable, move} = {4'b1001, 1'b1, 1'b1};
           endcase
          end
      1 : begin
           Stat_update = 0;
           if (Opcode == 4'd4) begin
             case(S)
              0  : {Execute_Command, mem_write} = {4'b0010, 1'b1};
              1  : {Execute_Command, WB_Enable, mem_read} = {4'b0010, 1'b1, 1'b1};
             endcase
           end
          end
      2 : begin
           Stat_update = 0;
           B = 1;
          end
      
    endcase
    
 end
    
endmodule
