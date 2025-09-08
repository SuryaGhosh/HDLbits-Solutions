module top_module(
    input clk,
    input reset,  // synchronous reset
    input in,      // T input
    output reg out  // output
);

    always @(posedge clk) begin
        if (reset)
            out <= 1'b1;             // reset to 0
        else if (!in)
            out <= ~out;               // toggle when T is 0
        // else: hold current state (Q remains unchanged)
    end

endmodule
