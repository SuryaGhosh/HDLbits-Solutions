module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        if (in == 1'b1) begin
            state = next_state;
        end if (in == 1'b0) begin
            state = !next_state;                    
        end
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            next_state <= B;
        end else begin
            next_state <= state;
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = next_state;

endmodule

