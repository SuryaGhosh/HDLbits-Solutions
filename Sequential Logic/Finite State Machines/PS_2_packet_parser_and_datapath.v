module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter BYTE1 = 2'd0, BYTE2 = 2'd1, BYTE3 = 2'd2, DONE = 2'd3;
    reg [1:0] current_state, next_state;
    
    // stores the incoming data
    reg [23:0] data;
    
    // next state logic
    always @(*) begin
        case (current_state) 
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = in[3] ? BYTE2 : BYTE1;
        endcase
    end
    
    // current state logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
        	current_state <= next_state;
        end
    end
    
    // output logic 
    assign done = (current_state == DONE);
    
    // New: Datapath to store incoming bytes.
    assign out_bytes = done ? data : 24'b0;
    
    // appends incoming data packet onto the end of the stored data 
    always @ (posedge clk) begin
        if (reset) begin
            data <= 24'b0;
        end else begin
            data <= {data[15:0], in};
        end
    end
endmodule

