module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    always @ (posedge clk) begin
        if (reset == 1'b1) begin
            q <= 10'd0;
        end else begin 
            if (q == 10'd999) begin
                q <= 10'd0;
            end else begin
            	q <= q + 1'd1;
            end
        end
    end
    
endmodule




// attempt 1, is considered bad practice in industry

/*
module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    wire ones_carry, tens_carry, hundreds_carry;
    wire [3:0] ones_q, tens_q, hundreds_q;
    
    counter_9 ones_digit(.clk(clk), .enable(1'd1), .load(1'd0), .reset(reset+hundreds_carry), .load_val(4'd0), .q(ones_q), .carry(ones_carry));
    counter_9 tens_digit(.clk(clk), .enable(ones_carry), .load(1'd0), .reset(reset+hundreds_carry), .load_val(4'd0), .q(tens_q), .carry(tens_carry));
    counter_9 hundreds_digit(.clk(clk), .enable(tens_carry), .load(1'd0), .reset(reset+hundreds_carry), .load_val(4'd0), .q(hundreds_q), .carry(hundreds_carry));
    
    assign q = hundreds_q * 10'd100 + tens_q * 10'd10 + ones_q;
endmodule

module counter_9 (
    input clk,
    input enable, 
    input load, 
    input reset, 
    input [3:0] load_val,
    output reg [3:0] q,
    output reg [0:0] carry);
	
    always @ (posedge clk) begin
        if ((load == 1'd1 ) + (reset == 1'd1)) begin
            q <= load_val;
            carry <= 1'd0;
        end else if (enable == 1'd1) begin
            if (q == 4'd9) begin
                q <= 4'd0;
                carry <= 1'd1;
            end else begin
                q <= q + 1'd1;
                carry <= 1'd0;
            end
        end
    end    
endmodule
    
    /*module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    always @(posedge clk) begin
        if (reset) q <= 0;
        else begin
            if (q < 999) q <= q + 1;
        	else q <= 0;
        end
    end

endmodule*/
    

