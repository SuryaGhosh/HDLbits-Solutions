module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        // D = fun(Q, inputs)
        case (state) 
            // condition ? true_result : false_result
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF: ON;
            default: next_state = OFF;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        // Q = updated D
        if (areset == 1'b1) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end 
    end

    // Output logic
    // output = state
    // assign out = (state == ...);
    assign out = state; 

endmodule

