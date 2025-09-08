module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign ena[1] = (q[3:0] == 4'b1001);
    assign ena[2] = (ena[1] == 1'b1 && (q[7:4] == 4'b1001));
    assign ena[3] = (ena[2] == 1'b1 && (q[11:8] == 4'b1001));
    
    
    count10 count_digit_0(.clk(clk), .reset(reset), .ena(1'b1), .q(q[3:0]));
    count10 count_digit_1(.clk(clk), .reset(reset), .ena(ena[1]), .q(q[7:4]));
    count10 count_digit_2(.clk(clk), .reset(reset), .ena(ena[2]), .q(q[11:8]));
    count10 count_digit_3(.clk(clk), .reset(reset), .ena(ena[3]), .q(q[15:12]));
                              
endmodule

// modified so it only increments on enable 
module count10 (
    input clk, 
    input reset,
    input ena,
    output reg [3:0] q); 
    
    // the counter holds the value of q in 4 FFs
		
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 1'b0;
        end
        else if (ena == 1'b1) begin
            // we need to handle if the counter is at 9
            if (q == 4'd9) begin
                q <= 4'd0;
            end
            else begin 
            	q <= q + 1'b1;
            end
        end
        else if (ena == 1'b0) begin 
            q <= q;
        end
    end
endmodule

