module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum);
    
    wire [1:0] con1;
    
    add16 adder_1(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(con1));    // stores .sum (the output from the module) into the variable sum[15:0]                       
    add16 adder_2(.a(a[31:16]), .b(b[31:16]), .cin(con1), .sum(sum[31:16]), .cout(1'b0)); //'disregard cout'    
endmodule

// 16 bit module provided

module add1 (input [1:0] a, 
             input [1:0] b, 
             input [1:0] cin, 
             output [1:0] sum, 
             output [1:0] cout);
    
    assign sum = a^b^cin;
    assign cout = (a&b)|(a&cin)|(b&cin);    
endmodule

