module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [2:0] cout; 
    
    FA FA_1(.a(x[0:0]), .b(y[0:0]), .cin(1'b0), .sum(sum[0:0]), .cout(cout[0:0]));
    FA FA_2(.a(x[1:1]), .b(y[1:1]), .cin(cout[0:0]), .sum(sum[1:1]), .cout(cout[1:1]));
    FA FA_3(.a(x[2:2]), .b(y[2:2]), .cin(cout[1:1]), .sum(sum[2:2]), .cout(cout[2:2]));
    FA FA_4(.a(x[3:3]), .b(y[3:3]), .cin(cout[2:2]), .sum(sum[3:3]), .cout(sum[4:4]));
    
    // used a[x] instead of a[x:x] from now on, its the standard

endmodule

module FA (
    input [0:0] a,
    input [0:0] b,
    input [0:0] cin,
    output [0:0] sum,
    output [0:0] cout);
    
    assign cout = a&b | a&cin | b&cin;
    assign sum = a^b^cin;    
endmodule
