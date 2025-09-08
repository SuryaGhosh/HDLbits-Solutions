module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    // state encodings 
    parameter START=5'd0, b0=5'd1, b1=5'd2, b2=5'd3, b3=5'd4, b4=5'd5, b5=5'd6, b6=5'd7, b7=5'd8, STOP=5'd9, IDLE_START=5'd10, IDLE_STOP=5'd11; 
    
    // current/next states 
    reg [4:0] current_state, next_state; 
    
    always @ (*) begin
        case (current_state) 
            START:		next_state = b0;
            b0:   		next_state = b1;
            b1:   		next_state = b2;
            b2:   		next_state = b3;
            b3:   		next_state = b4;
            b4:   		next_state = b5;
            b5:   		next_state = b6;
            b6:   		next_state = b7;
            b7:   		next_state = in ? STOP : IDLE_STOP; 
            STOP: 		next_state = in ? IDLE_START : START;
            IDLE_START: next_state = in ? IDLE_START : START;
            IDLE_STOP:  next_state = in ? IDLE_START : IDLE_STOP;
        endcase
    end
    
    // current state logic
    always @ (posedge clk) begin
        if (reset) begin
            current_state <= IDLE_START;
        end else begin
            current_state <= next_state;
        end
    end

    // output logic
    assign done = (current_state == STOP);
endmodule

