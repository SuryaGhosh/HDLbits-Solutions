module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
   
    
    // state encoding
    parameter S=4'd0, S1=4'd1, S11=4'd2, S110=4'd3, B0=4'd4, B1=4'd5, B2=4'd6, B3=4'd7, COUNT=4'd8, WAIT=4'd9;
    
    // state registers 
    reg [3:0] current_state, next_state;
    
    // parameters 
    reg done_counting;
    reg [9:0] count_1000;
    
    // next state logic
    always @ (*) begin
        case (current_state) 
            S     : next_state = data ? S1 : S;
            S1    : next_state = data ? S11 : S;
            S11   : next_state = data ? S11 : S110;
            S110  : next_state = data ? B0 : S;
            B0    : next_state = B1;
            B1    : next_state = B2;
            B2    : next_state = B3;
            B3    : next_state = COUNT;
            COUNT : next_state = done_counting ? WAIT : COUNT;
            WAIT  : next_state = ack ? S : WAIT;
        endcase
    end
       
    
    // counter 
    always @ (posedge clk) begin
        // resets counter to 0
        if (reset) begin
            count_1000 <= 10'd0;
        end 
        else begin
            case (current_state) 
                // shifts in delay duration (MSB is shifted in first)
    			// this is outputted as count (duration of the timer delay)
                B0 : count[3] = data;
                B1 : count[2] = data;
                B2 : count[1] = data;
                B3 : count[0] = data;
                COUNT : begin
                    // timer 
                    if (count >= 1'd0) begin
                        if (count_1000 < 10'd999) begin
                                count_1000 <= count_1000 + 1'd1;
                        end else begin
                                // resets count_1000 to 0 when it reaches 1000 and decrements count by 1
                                count_1000 <= 1'd0;
                                count <= count - 1'd1;
                        end
                    end
                end
            endcase
        end
    end 
    
    // checks if counter has stopped
    assign done_counting = (count == 1'd0) & (count_1000 == 10'd999);
    
    // current state logic
    always @ (posedge clk) begin
        if (reset) begin
            current_state <= S;
        end else begin
            current_state <= next_state;
        end
    end
    
    // output logic
    assign counting = (current_state == COUNT);
    assign done = (current_state == WAIT);

endmodule


