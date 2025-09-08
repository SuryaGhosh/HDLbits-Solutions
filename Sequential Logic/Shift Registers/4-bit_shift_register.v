module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
       
    always @(posedge clk or posedge areset) begin
        if (areset == 1'd1) begin // only triggered by reset 
            q <= 4'd0;
        end
        else if (load) begin // only triggered by clk
            q <= data;
        end
        else if (ena) begin // only triggered by clk
            q <= {1'b0, q[3:1]};
        end
    end   

endmodule

