module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    
    // 8 bit right shift:
    // 101100000
    
    // {MSB, LSB}
    // 4'd11: {1,0,1,1}
    // to access 0: num[2]
    // left shift = multiply by 2
    // we don't need to track the sign for this as a negative_num * 2 can equal positive,
    // so the MSB may change from 1 to 0
    
    always @ (posedge clk) begin
        if (load) begin
            q <= data;
        end 
        else if (ena) begin
            if (amount == 2'b00) begin
                q <= {q[62:0], 1'b0};
            end
            else if (amount == 2'b01) begin
                q <= {q[55:0], 8'b0};
            end
            else if (amount == 2'b10) begin
                q <= {q[63], q[63:1]};
            end
            else if (amount == 2'b11) begin
                q <= {{8{q[63]}}, q[63:8]};
            end
        end 
        else begin
            q <= q;
        end
        
    end

endmodule

