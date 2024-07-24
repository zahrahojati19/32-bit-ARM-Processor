module ALU(cmd, SR, Val1, Val2, status, result);
  
    input [3:0] cmd, SR;
    input [31:0] Val1, Val2;
    
    output [3:0] status;
    output reg [31:0] result;
    wire N, Z, N_in, Z_in, C_in, V_in;
    reg C, V;

    assign {N_in, Z_in, C_in, V_in} = SR;
    assign N = result[31];
    assign Z = ~(|result);
    assign status = {N, Z, C, V};

    always @(Val1, Val2, cmd, SR) begin
        result = 32'bx;
        C = C_in;
        V = V_in;
        case (cmd)
            4'b0001: begin: MOV
                result = Val2;
            end
            4'b1001: begin: MVN
                result = ~Val2;
            end
            4'b0010: begin: ADD_LDR_STR
                {C, result} = Val1 + Val2;
                V = ((Val1[31] & Val2[31]) & ~result[31]) | ((~Val1[31] & ~Val2[31]) & result[31]);
            end
            4'b0011: begin: ADC
                {C, result} = Val1 + Val2 + C_in;
                V = ((Val1[31] & Val2[31]) & ~result[31]) | ((~Val1[31] & ~Val2[31]) & result[31]);
            end
            4'b0100: begin: SUB_CMP
                {C, result} = Val1 - Val2;
                V = ((~Val1[31] & Val2[31]) & result[31]) | ((Val1[31] & ~Val2[31]) & ~result[31]);
            end
            4'b0101: begin: SBC
                {C, result} = Val1 - Val2 - {31'b0, ~C_in};
                V = ((~Val1[31] & Val2[31]) & result[31]) | ((Val1[31] & ~Val2[31]) & ~result[31]);
            end
            4'b0110: begin: AND_TST
                result = Val1 & Val2;
            end
            4'b0111: begin: ORR
                result = Val1 | Val2;
            end
            4'b1000: begin: EOR
                result = Val1 ^ Val2;
            end
            default: result = 32'b0;
        endcase
    end

endmodule