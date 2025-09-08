module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    // state encodings
    parameter SNT=2'd0, WNT=2'd1, WT=2'd2, ST=2'd3;
    
    // current/next states
    reg [1:0] current_state, next_state;
    
    // next state logic
    always @ (*) begin
        case (current_state)
            SNT : next_state = train_valid ? (train_taken ? WNT : SNT) : SNT;
            WNT : next_state = train_valid ? (train_taken ? WT  : SNT) : WNT;
            WT  : next_state = train_valid ? (train_taken ? ST  : WNT) : WT;
            ST  : next_state = train_valid ? (train_taken ? ST  : WT)  : ST;
        endcase
    end
    
    // current state logic
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
        	current_state <= WNT;
        end else begin
        	current_state <= next_state;
        end
    end
    
    // output logic
    assign state = current_state;

endmodule

