module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out );
      
    always @(*) begin 
        // the index, sel, is variable, so out must be reassigned every time it updates
        // thus we cannot use assign, and must use an always block
        out = in[sel*4 +: 4]; // selects [base +: width]
    end 
    
endmodule

