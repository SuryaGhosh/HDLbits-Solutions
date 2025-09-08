`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );  
    
    wire and2_wire_a, and2_wire_b, or2_wire_c;
    
    assign and2_wire_a = a && b;
    assign and2_wire_b = c && d;
    assign or2_wire_c = and2_wire_a || and2_wire_b;
    assign out = or2_wire_c;
    assign out_n = !or2_wire_c;

endmodule

