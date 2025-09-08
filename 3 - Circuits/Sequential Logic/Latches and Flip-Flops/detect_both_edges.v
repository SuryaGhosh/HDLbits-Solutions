module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    
    // any edge = signal changes parity 
    
    reg [7:0] prev_in; 
    
    always @(posedge clk) begin
    	prev_in <= in;
        anyedge <= in ^ prev_in;
    end

endmodule

