module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3:0] q;
    
    always @(posedge clk) begin
        if (!resetn) begin
            q[3:0] = 4'b0;
        end else begin
            q[0] <= in;
            q[3:1] <= q[2:0];
            //out <= q[3];
        end
    end
    
    assign out = q[3];

endmodule

