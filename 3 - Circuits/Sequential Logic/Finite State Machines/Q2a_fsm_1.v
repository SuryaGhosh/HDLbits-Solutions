module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    // state encodings
    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5;
    
    // state registers
    reg [2:0] current_state, next_state;
    
    // next state logic
    always @(*) begin
        case (current_state)
       	    A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
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

