// I was unable to implement the parity checking mechanism using my implementation for the serial receiver and datapath. 
// After many attempts, I had to change my approach, and used a counter to track the bits received and determine parity.
// I used this repo for help: https://gitee.com/mosqlwj/Solutions-to-HDLbits-Verilog-sets/blob/master/3.circuits/sequential%20logic/136.serial_receiver_and_datapathe.v

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    // state encodings 
    parameter START= 3'd0, IDLE_START=3'd1, STOP=3'd2, IDLE_STOP=3'd3, RECEIVE=3'd4, CHECK=3'd5;
    
    // tracks number of bits received
    reg [3:0] i;

    // current/next states 
    reg [2:0] current_state, next_state; 
    
    // stores data
    reg [7:0] data;
    reg parity_reset;
    wire odd;
    reg odd_reg; 

    // parity checker instance 
    parity u_parity(
        .clk(clk),
        .reset(reset | parity_reset),   // reset at start of new frame
        .in(in),
        .odd(odd)
    );
    
    // next state logic
    always @(*) begin
        case (current_state) 
            START:       next_state = RECEIVE;
            RECEIVE:     next_state = (i == 8) ? CHECK : RECEIVE; 
            CHECK:		 next_state = in ? STOP : IDLE_STOP;
            STOP:        next_state = in ? IDLE_START : START;
            IDLE_START:  next_state = in ? IDLE_START : START;
            IDLE_STOP:   next_state = in ? IDLE_START : IDLE_STOP;
            default:     next_state = IDLE_START;
        endcase
    end 
    
    // tracks number of bits_received
    always @ (posedge clk) begin
        if (reset) begin
        	i <= 4'd0;
        end else if (next_state == RECEIVE) begin
            i = i + 1'b1;
        end else begin
        	i <= 4'd0;
        end
    end
    
    // current state logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE_START;
        end else begin
            current_state <= next_state;
        end
    end
    
    // done pulses when we enter STOP (valid frame received)
    assign done = (current_state == STOP) && odd_reg;
    
    // datapath: shift in bits during data states
    always @(posedge clk) begin     
        if (reset) begin
            data <= 8'b0;
        end 
        else if (next_state == RECEIVE) begin
            data[i] <= in;    
        end 
    end
    
    // resets parity counter
    always @(posedge clk) begin
        if (next_state == IDLE_START | next_state == STOP) begin
            parity_reset <= 1'b1;
        end else begin
            parity_reset <= 1'b0;
        end
    end
    
    always @(posedge clk) begin
    	if(reset) odd_reg <= 0;
    	else odd_reg <= odd; 
    end
    
    // latch the byte only if done is asserted
    assign out_byte = done ? data : 8'b0;
endmodule


