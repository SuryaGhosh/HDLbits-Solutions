module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [0:0] carry_1, carry_2;
    add16 adder_1(.a(a[15:0]), 
                  .b(b[15:0]^{16{sub}}), 
                  .cin(sub), 
                  .sum(sum[15:0]), 
                  .cout(carry_1)
                 );
    add16 adder_2(.a(a[31:16]), 
                  .b(b[31:16]^{16{sub}}), 
                  .cin(carry_1), 
                  .sum(sum[31:16]),
                  .cout(carry_2)
                 );
endmodule
