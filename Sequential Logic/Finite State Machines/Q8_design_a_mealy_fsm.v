module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    // mealy fsm: output is dependent on both current state and input
    
    parameter S0=2'd0, S1=2'd1, S2=2'd2;
    reg [1:0] current_state, next_state;
    
    // next state and output logic
    
    always @ (*) begin
        case (current_state) 
            S0 : begin 
                next_state = x ? S1 : S0;
                z = 1'd0;
            end    
            S1 : begin
                next_state = x ? S1 : S2;
                z = 1'd0;
            end
            S2 : begin
                next_state = x ? S1 : S0;
                z = x;
            end
        endcase
    end
    
    // current state logic
    always @ (posedge clk, negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end
endmodule

