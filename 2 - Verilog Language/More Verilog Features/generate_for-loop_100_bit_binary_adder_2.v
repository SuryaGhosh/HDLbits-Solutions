module FA (
    input [0:0] a, b, cin,
    output [0:0] sum, cout);
    assign sum = a^b^cin;
    assign cout = (a&b)|(a&cin)|(b&cin);
endmodule 

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    genvar i;
    
    generate 
        FA(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout[0]));
        
        for (i=1; i<100; i++) begin: FA_Blocks
            FA(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .cout(cout[i]), .sum(sum[i]));
        end 
    endgenerate 
    
    
endmodule

