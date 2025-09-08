module top_module( 
    input [2:0] in,
    output [1:0] out );
	// FA approach
    //assign out[0] = in[2] ^ in[1] ^ in[0];
    //assign out[1] = in[2]&in[1] | in[2]&in[0] | in[1]&in[0];
    
    // iterative approach
    integer i;
    // assign drives the variable constantly, so we cannot use it inside an always block 
    //assign out = 1'b0;
    // a latch is inferred if out is assigned outside the always @(*) block, since it needs to 
    // be remembered to be used later on
    
    always @(*) begin 
        // a latch is inferred if out is not assigned, since it is never given a value 
        // inside here, a latch isn't required since out is being calculated constantly 
        out = 1'b0;
        for (i=0; i<3; i++) begin
            if (in[i] == 1'b1) begin
                out += 1'b1; 
            end
        end 
    end 
    
endmodule

