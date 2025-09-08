module top_module (
    input clk,
    input in, 
    output out);
    
    wire [0:0] d,q;
    
    
    always @ (posedge clk) begin
    	d = q^in;
        q = d;
        out = d;
    end

endmodule

