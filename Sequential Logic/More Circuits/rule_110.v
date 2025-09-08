module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    // next_center =  (center ^ right) + (center*!left)
    
    // shift q to get right/left versions
    wire [511:0] q_left, q_right;
    assign q_left = q >> 1;    // right shift q to compare current q with its left neighbour
    assign q_right = q << 1;
    
    always @ (posedge clk) begin
        if (load == 1'b1) begin
        	q <= data;
        end else begin
            // we no longer worry about boundary conditions since a 0 will be filled in via shifting 
            // MSB.....LSB
            //q <= (q ^ q_right) | (q & !q_left);       // mine
            q <= (q ^ q_right) | (~q_left & q_right); // theirs
        end
    end     
endmodule

