module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] con1;
    wire [31:0] con2;
    
    add16 add16_1 (.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .cout(con1), .sum(sum[15:0]));
    add16 add16_2 (.a(a[31:16]), .b(b[31:16]), .cin(con1), .cout(1'b0), .sum(sum[31:16])); 
endmodule

