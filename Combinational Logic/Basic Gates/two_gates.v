module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    
    wire [0:0] xnor_wire = ~(in1^in2);
    assign out = xnor_wire^in3;
    
endmodule

