module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    // these are the different blocks/connections. we still haven't established the logic 
    // we instantiate this just once 
    wire [7:0] con1, con2, con3;
    my_dff8 dff_1(.clk(clk), .d(d), .q(con1));
    my_dff8 dff_2(.clk(clk), .d(con1), .q(con2));
    my_dff8 dff_3(.clk(clk), .d(con2), .q(con3));
    
    // multiplexer 
    // this logic happens constantly
    // for flip-flops this would be ex: always @ (posedge clk) 
    always @ (*) begin
  
       case(sel)
            2'b00: q = d ;
            2'b01: q = con1;
            2'b10: q = con2;
            2'b11: q = con3;
        endcase
    end 
endmodule

