module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    always @ (posedge clk) begin
        if (shift_ena == 1'b1) begin
            q <= {q[2:0],data};
        end else if (count_ena == 1'b1) begin
            if (q == 4'd0) begin
                q <= 4'd15;
            end else begin
            	q <= q - 1'b1;
            end
        end
    end

endmodule

