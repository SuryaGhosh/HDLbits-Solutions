module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    // state encodings
    parameter START=4'd0, IN1=4'd1, IN2=4'd2, IN3=4'd3, IN4=4'd4, IN5=4'd5, IN6=4'd6, 
    	      DISC=4'd7, FLAG=4'd8, ERROR=4'd9;
    
    // registers
    reg [3:0] current_state, next_state;
    
    // next state logic
    always @(*) begin
        case (current_state)
            START: next_state = in ? IN1 : START;
            IN1:   next_state = in ? IN2 : START;
            IN2:   next_state = in ? IN3 : START;
            IN3:   next_state = in ? IN4 : START;
            IN4:   next_state = in ? IN5 : START;
            IN5:   next_state = in ? IN6 : DISC;
            IN6:   next_state = in ? ERROR : FLAG;
            DISC:  next_state = in ? IN1 : START;
            FLAG:  next_state = in ? IN1 : START;
            ERROR: next_state = in ? ERROR : START;
            default: next_state = START;
        endcase
    end
    
    // current state logic 
    always @(posedge clk) begin
        if (reset) begin
            current_state <= START;
        end else begin
            current_state <= next_state;
        end
    end
    
    // output logic
    assign disc = (current_state == DISC);
    assign flag = (current_state == FLAG);
    assign err = (current_state == ERROR);

endmodule

