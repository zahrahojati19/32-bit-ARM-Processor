module hazard_unit(fu, EXE_MEM_R, two_src, move, WB_MEM, WB_EXE, RD_MEM, RD_EXE, reg_1, reg_2, hazard);

    input two_src, move, WB_MEM, WB_EXE, fu, EXE_MEM_R;
    input [3:0] RD_MEM, RD_EXE, reg_1, reg_2;
    
    output reg hazard;
    
    always @* begin
        hazard = 1'b0;
	if(fu)begin
		if(EXE_MEM_R & ((reg_1 == RD_EXE)|(reg_2 == RD_EXE)))
			hazard = 1'b1;
	end
	else begin
        	if (two_src)
        		if((WB_EXE & (RD_EXE == reg_2)) | (WB_MEM & (RD_MEM == reg_2)))
                		hazard = 1'b1;
        	if (~move)
            		if ((WB_EXE & (RD_EXE == reg_1)) | (WB_MEM & (RD_MEM == reg_1)))
                		hazard = 1'b1;
    	end
    end
endmodule
