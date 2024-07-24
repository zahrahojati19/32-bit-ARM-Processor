module Val2Generate(
    input I, mem_read_or_write,
    input [11:0] shifter_operand,
    input [31:0] reg2,
    output reg [31:0] Val2
);
    
    wire [3:0] rotate_imm;
    wire [7:0] immed_8;
    wire [1:0] shift;
    wire [4:0] shift_imm;
    wire [63:0] ar_shift_bus, rot_bus, imm_rot_bus;

    assign rotate_imm = shifter_operand[11:8];
    
    assign immed_8 = shifter_operand[7:0];
    
    assign shift_imm = shifter_operand[11:7];
    
    assign shift = shifter_operand[6:5];
    
    assign ar_shift_bus = {{32{reg2[31]}}, reg2};
    
    assign rot_bus = {2{reg2}};
    
    assign imm_rot_bus = {2{{24'b0}, immed_8}};

    always @* begin
        Val2 = 32'b0;
        if (mem_read_or_write) begin: STR_LDR
            Val2 = {20'b0, shifter_operand};
        end
        else if (I) begin: immediate
            Val2 = imm_rot_bus[31+(rotate_imm << 1) -: 32];
        end
        else begin
            case (shift)
                2'b00: begin: LSL
                    Val2 = reg2 << shift_imm;
                end
                2'b01: begin: LSR
                    Val2 = reg2 >> shift_imm;
                
                end
                2'b10: begin: ASR
                    Val2 = ar_shift_bus[31+shift_imm -: 32];
                end
                2'b11: begin: ROR
                    Val2 = rot_bus[31+shift_imm -: 32];
                end
            endcase
        end
    end

endmodule