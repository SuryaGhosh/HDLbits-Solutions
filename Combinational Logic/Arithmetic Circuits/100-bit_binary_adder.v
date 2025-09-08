module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    //reg [100:0] sum_carry_bits;
    
    //assign sum_carry_bits [100:0] = a+b+cin;
    //assign sum [99:0] = sum_carry_bits [99:0];
    //assign cout = sum_carry_bits [100];
    
    wire [100:0] cout_wire;
    assign cout_wire[0] = cin;
    
    genvar i;
    
    generate
        for (i=0; i<100; i++) begin: FA_Chain
            FA(.a(a[i]), .b(b[i]), .cin(cout_wire[i]), .sum(sum[i]), .cout(cout_wire[i+1]));
        end
    endgenerate 
    
    assign cout = cout_wire[100];

endmodule

module FA (
    input [0:0] a, b, cin,
    output [0:0] sum, cout);
    
    assign sum = a^b^cin;
    assign cout = a&b | a&cin | b&cin;
endmodule 

