module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
   
    
    always @(posedge clk) begin
        if (load == 1'b1) begin
            q <= data;
        end else begin
            // a cells next state is the xor of its 2 neighbors 
            // the boundaries, q [512] and q[-1] are constant 0
            
            // boundary condition
            q[0] <= q[1];
            q[511] <= q[510];
            // check middle bits
            for (integer i=1; i<511; i+=1) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
endmodule

