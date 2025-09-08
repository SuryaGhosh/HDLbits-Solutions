module top_module (
    input clk,
    input d,
    output q
);
    
    reg [0:0] wire_pos, wire_neg; 
    
    always @(posedge clk) begin
        wire_pos <= d ^ wire_neg;
    end
    
    always @(negedge clk) begin
        wire_neg <= d ^ wire_pos;
    end
    
    assign q = wire_pos ^ wire_neg;
endmodule

