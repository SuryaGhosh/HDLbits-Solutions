module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;
    
    reg [2:0] current_state, next_state;
    
    // next state logic
    always @ (*) begin
        case (current_state) 
        	S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3;
            default next_state = S0;
        endcase
    end
    
    // current state logic (DFFs)
    always @ (posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end
    
    // output logic
    assign z = (current_state == S3) + (current_state == S4);
endmodule

