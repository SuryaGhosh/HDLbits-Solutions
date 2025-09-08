module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    // stores current count cycle
    reg [9:0] count_time;
    
    always @ (posedge clk) begin
        if (load) begin
            count_time <= data;
        end else if(count_time > 1'd0) begin 
            count_time <= count_time - 1'd1;
        end else begin
        	count_time <= count_time;
        end
    end
    
    assign tc = (count_time == 1'd0);

endmodule

