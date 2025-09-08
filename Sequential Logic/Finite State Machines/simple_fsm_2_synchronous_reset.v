module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  
    
    parameter OFF = 1'b0, ON = 1'b1, reset_val = 3'h0FF;
    reg current_state, next_state;
    
    // transitional logic (current state)
    always @(*) begin
        case (current_state) 
            OFF: next_state = j;
            ON:  next_state = !k;
            default: next_state = next_state;
        endcase
    end
    
    // sequentual logic (next_state)
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end
        
    // output logic 
    assign out = current_state;
    
endmodule 

