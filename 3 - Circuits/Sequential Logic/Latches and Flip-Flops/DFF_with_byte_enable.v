module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    
    // byteena []
    ///q [15:0] = 15'b0;
    
    // only trigger on the posedge; check for reset then
    always @(posedge clk) begin
        case (byteena) 
            2'b00: q <= q; 
            2'b01: q[7:0] <= d[7:0]; 
            2'b10: q[15:8] <= d[15:8];
            2'b11: q[15:0] <= d[15:0]; 
            default: q <= q;
        endcase 
        if (resetn == 1'b0) begin
			q <= 15'b0;
        end
    end 
endmodule

