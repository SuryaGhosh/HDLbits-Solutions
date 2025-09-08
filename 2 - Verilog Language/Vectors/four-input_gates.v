module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    // both && and || work because we are comparing the numbers bit by bit and then outputting a 1 bit result
    assign out_and = in[3] && in && in[2] && in[1] && in[0];
    assign out_or = in[3] || in[2] || in[1] || in[0];
    assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];
    

endmodule

