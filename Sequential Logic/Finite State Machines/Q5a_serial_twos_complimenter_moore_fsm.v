module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    // TC: starting from LSB, pass everything through until the first '1' appears, let the 1 pass,
    // then invert everything thereafter
    // We don't have to worry about the reset deasserting as the TC conversion stops happening due to the sensitivity list
    
    // states
    parameter PASS = 2'd0, ONE = 2'd1, ZERO = 2'd2;
    
    // states reg 
    reg [1:0] current_state, next_state;
    
    // next state logic
    always @ (*) begin
        case (current_state) 
        	PASS   : next_state = x ? ONE : PASS; 
            ONE    : next_state = x ? ZERO : ONE;
            ZERO   : next_state = x ? ZERO : ONE;
        endcase
    end
    
    // current state logic
    always @ (posedge clk, posedge areset) begin
        // if reset is asserted, then the conversion stops 
        if (areset) begin
            current_state <= PASS;
        // if the reset is released, ie this block is triggered by the clk, then the conversion continues 
        end else begin
            current_state <= next_state;
        end        
    end    
    
    // output logic 
    assign z = (current_state == ONE);
endmodule
