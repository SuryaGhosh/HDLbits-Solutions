module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4;
    reg [2:0] current_state, next_state;
    
    always @ (*) begin
        case (current_state) 
        	S0 : next_state = S1;
            S1 : next_state = S2;
            S2 : next_state = S3;
            S3 : next_state = S4;
            S4 : next_state = S4;   
            default: next_state = S0;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset) begin
        	current_state <= S0;
        end else begin
        	current_state <= next_state;
        end
    end
    
    assign shift_ena = (S0 <= current_state) & (current_state <= S3);

endmodule

