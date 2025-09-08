module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    // state encodings
    // Below S1: S0
    // S2-S1: S1
    // S3-S2: S2
    // Above S3: S3
    // Extra Flow 2: S4
    // Extra Flow 1: S5
    parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4, S5 = 3'd5;
    reg [2:0] current_state, next_state;
    
    // next (transition) state logic
    // inputs: current state (Q), external inputs
    // outputs: next state (D)
    always @ (*) begin
        case (current_state)
            S0: if (s == 3'b000) 
                	next_state = S0;
                else if (s == 3'b001) 
                	next_state = S1;
            S1: if (s == 3'b000)
                	next_state = S0;
            	else if (s == 3'b001)
                	next_state = S1;
            	else if (s == 3'b011)
                	next_state = S2;
            S2: if (s == 3'b011)
                	next_state = S2;
            	else if (s == 3'b111) 
                	next_state = S3;
            	else if (s == 3'b001)
                	next_state = S5;
            S3: if (s == 3'b111)
                	next_state = S3;
            	else if (s == 3'b011)
                	next_state = S4;
            S4: if (s == 3'b011)
                	next_state = S4;
            	else if (s == 3'b001)
                	next_state = S5;
            	else if (s == 3'b111)
                	next_state = S3;
            S5: if (s == 3'b000)
                	next_state = S0;
            	else if (s == 3'b001)
                	next_state = S5;
            	else if (s == 3'b011) 
                	next_state = S2;
            default: next_state = S0;
        endcase
    end
    
    // current state logic
    // inputs: next state (D)
    // outputs: current state (Q)
    // next state becomes current state on posedge clk
    always @ (posedge clk) begin
        if (reset == 1'b1) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end
    
    // output logic
    // inputs: current state (Q)
    // outputs: output 
    always @ (*) begin
        case (current_state)
            S0: {fr1, fr2, fr3, dfr} = 4'b1111; 
            S1: {fr1, fr2, fr3, dfr} = 4'b1100;
            S2: {fr1, fr2, fr3, dfr} = 4'b1000;
            S3: {fr1, fr2, fr3, dfr} = 4'b0000;
            S4: {fr1, fr2, fr3, dfr} = 4'b1001;
            S5: {fr1, fr2, fr3, dfr} = 4'b1101;
        endcase 
    end
endmodule

