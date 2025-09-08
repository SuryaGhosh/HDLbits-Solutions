module top_module ( input clk, input d, output q );
	wire con1, con2;
    my_dff dff_1(.clk(clk), .d(d), .q(con1));
    my_dff dff_2(.clk(clk), .d(con1), .q(con2));
    my_dff dff_3(.clk(clk), .d(con2), .q(q));
endmodule



