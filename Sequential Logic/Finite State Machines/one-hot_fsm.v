module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    parameter S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, 
              S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, 
              S6 = 4'd6, S7 = 4'd7, S8 = 4'd8, 
              S9 = 4'd9;
    
    // transition logic
    always @(*) begin
        next_state[S0] = ((state[S0] | state[S1] | state[S2] | state[S3] | state[S4] | state[S7] | state[S8] | state[S9]) & ~in);
        next_state[S1] = (state[S0] | state[S8] | state[S9]) & in;
        next_state[S2] = state[S1] & in;
        next_state[S3] = state[S2] & in;
        next_state[S4] = state[S3] & in;
        next_state[S5] = state[S4] & in;
        next_state[S6] = state[S5] & in;
        next_state[S7] = (state[S6] | state[S7]) & in;
        next_state[S8] = state[S5] & ~in;
        next_state[S9] = state[S6] & ~in;      
    end
    
    // output logic 
    assign out1 = state[S8] | state[S9];
    assign out2 = state[S7] | state[S9];    
endmodule
