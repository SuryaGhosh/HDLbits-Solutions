module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5;
    
    reg [2:0] current_state, next_state;
    
    // next state logic
    always @(*) begin
        case (current_state) 
            A : next_state = w ? A : B;
            B : next_state = w ? D : C;
            C : next_state = w ? D : E;
            D : next_state = w ? A : F;
            E : next_state = w ? D : E;
            F : next_state = w ? D : C;
        endcase
    end
    
    // current state logic 
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // output logic 
    assign z = (current_state == E) + (current_state == F);

endmodule

