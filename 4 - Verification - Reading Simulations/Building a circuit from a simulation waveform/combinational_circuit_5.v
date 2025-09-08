module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q );
    
    // c = 0 : q = b
    // c = 1 : q = e
    // c = 2 : q = a
    // c = 3 : q = d
    // c = 4 : q = 4'hf
    
    // ERROR: latches will be inferred; if c is assigned a value other than 0,1,2,3,4, then the systhesis
    // tool chooses the last picked value. If the last picked value was 3, then it will be 3 again since 
    // it is storred within the latch 
    
    always @ (*) begin
        case (c) 
            0 : q = b;
            1 : q = e;
            2 : q = a;
            3 : q = d;
            default : q = 4'hf; 
        endcase
    end

endmodule

