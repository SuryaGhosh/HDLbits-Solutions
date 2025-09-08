module top_module( 
    input [7:0] in,
    output [7:0] out
);
    genvar i;
    generate 
        for (i=0; i<8; i++) begin: bit_reversal 
            assign out[7-i] = in[i];
        end
    endgenerate 
        

endmodule

