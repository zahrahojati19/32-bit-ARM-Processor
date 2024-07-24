module Forwarding_Unit(fu, src1, src2, WB_EN_mem, WB_EN_wb, Dest_mem, Dest_wb, Sel_src1, Sel_src2);
	input [3:0] src1, src2;
	input fu, WB_EN_mem, WB_EN_wb;
	input [3:0] Dest_mem, Dest_wb;
	output reg [1:0] Sel_src1, Sel_src2;

	always @* begin
		Sel_src1 = 2'b00;
		Sel_src2 = 2'b00;
		if(fu) begin
			if((src1 == Dest_mem) & WB_EN_mem)begin
				Sel_src1 = 2'b01;
			end
			else if((src1 == Dest_wb) & WB_EN_wb)begin
				Sel_src1 = 2'b10;
			end 
			if((src2 == Dest_mem) & WB_EN_mem)begin
				Sel_src2 = 2'b01;
			end
			else if((src2 == Dest_wb) & WB_EN_wb)begin
				Sel_src2 = 2'b10;
			end
		end 
  	end
endmodule
