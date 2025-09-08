module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    genvar i;
    wire [99:0] cout_wires;
    
    generate 
        bcd_fadd fadd(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout_wires[0]), .sum(sum[3:0]));
        for (i=4; i<400; i+=4) begin: bcd_adder_instances
            bcd_fadd fadd(.a(a[i+3:i]), .b(b[i+3:i]), .cin(cout_wires[i/4-1]), .cout(cout_wires[i/4]), .sum(sum[i+3:i]));
        end
    endgenerate 
    assign cout = cout_wires [99:99];
endmodule

