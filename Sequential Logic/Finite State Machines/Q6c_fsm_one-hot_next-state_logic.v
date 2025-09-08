module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
    // starts at bit 1 
    // Y2 = B
    // Y4 = D
    
    assign Y2 = (y[1] * !w);
    assign Y4 = (y[2] | y[3] | y[5] | y[6]) * w; // B C E F

endmodule

