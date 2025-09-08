module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] prev_in = {32{1'b0}};
       
    always @(posedge clk) begin
        prev_in <= in;
        
        if (reset == 1'b1) begin
            out <= {32{1'b0}};
        end
        else begin
            out <= out | (prev_in & ~in);
        end
    end

endmodule

