module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter NO_DIGITS=3'd0, DIGIT_1=3'd1, DIGIT_2=3'd2, DIGIT_3=3'd3, DIGIT_4=3'd4;
    reg [2:0] current_state, next_state;
    
    always @ (*) begin
        case (current_state)
        	NO_DIGITS: next_state = data ? DIGIT_1 : NO_DIGITS;
            DIGIT_1:   next_state = data ? DIGIT_2 : NO_DIGITS;
            DIGIT_2:   next_state = data ? DIGIT_2 : DIGIT_3;
            DIGIT_3:   next_state = data ? DIGIT_4 : NO_DIGITS;
            DIGIT_4:   next_state = DIGIT_4;  
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset) begin
        	current_state <= NO_DIGITS;
        end else begin
            current_state <= next_state; 
    	end
    end
    
    assign start_shifting = (current_state == DIGIT_4);

endmodule

