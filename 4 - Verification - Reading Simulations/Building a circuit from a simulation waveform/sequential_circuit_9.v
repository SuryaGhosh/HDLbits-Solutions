module top_module (
    input clk,
    input a,
    output [3:0] q );
   
    reg [3:0] prev_q;
    
    always @ (posedge clk) begin
        if (a == 1'b1) begin
        	q <= 4'd4;
            prev_q <= 4'd4;
        end else begin
            if (prev_q == 4'd6) begin
            	q <= 4'd0;
                prev_q <= 4'd0;
            end else begin
            	q <= prev_q + 1'd1;
                prev_q = prev_q + 1'd1;
            end
        end
    end

endmodule

