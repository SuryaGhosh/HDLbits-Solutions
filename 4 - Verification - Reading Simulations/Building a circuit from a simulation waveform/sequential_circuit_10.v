module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    // state registers
    reg [0:0] next_state;
    
    // next state logic
    always @ (*) begin
        if (a == b) begin
            next_state = a;
        end else begin 
            next_state = state;
    	end    
    end
    
    // current state logic
    always @ (posedge clk) begin
    	state <= next_state;
    end
    
    // output logic
    assign q = (a==b) ? state : ~state;

endmodule

