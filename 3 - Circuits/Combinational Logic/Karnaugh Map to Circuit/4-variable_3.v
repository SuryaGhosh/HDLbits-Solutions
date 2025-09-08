module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out = a^b^c^d;
    // let x = a^b, y = c^d
    // out = (x & ~y) | (~x & y)
    // out = x^y
    // out = a^b^c^d
endmodule

