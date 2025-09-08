module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //     
    
    // S0: left S1: right
    reg current_state, next_state;
    parameter S0 = 1'd0, S1 = 1'd1;
    
    // next state logic 
    always @ (*) begin
        case (current_state)
            S0: next_state = bump_left;
            S1: next_state = !bump_right;
        endcase
    end
    
    // current state logic
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            current_state <= S0; 
        end else if (clk) begin
            current_state <= next_state;
        end
    end
    
    // output logic 
    assign walk_left = !current_state;
    assign walk_right = current_state;
endmodule

