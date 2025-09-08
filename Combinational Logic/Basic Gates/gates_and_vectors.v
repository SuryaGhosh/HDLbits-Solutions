module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
    
    integer i, count;
    
    // out both: we can compare in[2:0] with in[3:1].
    // in[3:1] creates a vector of elements 3,2,1. 
    assign out_both = in[2:0] & in[3:1];
    assign out_any =  in[3:1] | in[2:0];
    
    // compare the first 3 bits and the wrapping bits separately 
    // concatenate them
    assign out_different = {in[3:3]^in[0:0], in[2:0]^in[3:1]};
      

endmodule

