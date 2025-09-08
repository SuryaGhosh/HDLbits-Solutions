module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    // only implement shift_ena
    
    // state encoding
    parameter S=4'd0, S1=4'd1, S11=4'd2, S110=4'd3, B0=4'd4, B1=4'd5, B2=4'd6, B3=4'd7, Count=4'd8, Wait=4'd9;
    
    // state registers 
    reg [3:0] current_state, next_state;
    
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
            B3    : next_state = Count;
            Count : next_state = done_counting ? Wait : Count;
            Wait  : next_state = ack ? S : Wait;
        endcase
    end
    
    // current state logic
    always @ (posedge clk) begin
        if (reset) begin
            current_state <= S;
        end else begin
            current_state <= next_state;
        end
    end
    
    // output logic
    assign shift_ena = ((current_state >= B0) & (current_state <= B3));
    assign counting = (current_state == Count);
    assign done = (current_state == Wait);

endmodule

