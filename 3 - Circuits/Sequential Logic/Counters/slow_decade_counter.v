module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    
    always @ (posedge clk) begin
        // need to pause it if slowena == 0 when it has reached 9 instead of looping to 0
        // check for slowena first, then increment if slowena = 0
        if (reset == 1'd1 || q == 4'd9 && slowena == 1'd1) begin
            q <= 4'b0000;
        end  
        else begin
             q <= q + slowena;
        end
    end 

endmodule

