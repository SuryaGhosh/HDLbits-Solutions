module FA (
    input [0:0] a, b, cin,
    output [0:0] sum, cout);
    
	assign cout = a&b | a&cin | b&cin;
    assign sum = a^b^cin;
    
endmodule

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    //wire cout1, cout2, cout3;

    FA FA_1(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum[0]));
    FA FA_2(.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
    FA FA_(.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum[2]));
    
    
endmodule

