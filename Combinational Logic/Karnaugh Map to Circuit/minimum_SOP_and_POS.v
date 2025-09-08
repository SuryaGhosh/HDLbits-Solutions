module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
    // AB    00 01 10 11
    // CD 00 0  0
    //    01 0  0  0  0
    //    10 1  0  0  0 
    //    11    1     1
    
    always @(*) begin 
         out_sop = c&d | ~(a|b)&c;
   		 out_pos = out_sop;
    end 
   
endmodule

