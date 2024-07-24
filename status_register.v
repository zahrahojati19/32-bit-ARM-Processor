module status_register(clk, rst, S, SR_in, SR);
  
    input clk, rst;
    input S;
    input [3:0] SR_in;
    
    output [3:0] SR;

    reg [31:0] status_reg;

    assign SR = status_reg[31:28];
    
    always @(negedge clk, posedge rst) begin
        if (rst)
            status_reg = 32'b0;
        else if (S)
            status_reg = {SR_in, {28'b0}};
    end

endmodule