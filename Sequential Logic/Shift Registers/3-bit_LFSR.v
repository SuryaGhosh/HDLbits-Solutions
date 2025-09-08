module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
	
    wire Q0, Q1, Q2;
    
    dff_mux dff_mux_1(.D({SW[0], LEDR[2]}), .KEY(KEY), .Q(LEDR[0])); // {MSB, LSB}
    dff_mux dff_mux_2(.D({SW[1], LEDR[0]}), .KEY(KEY), .Q(LEDR[1]));
    dff_mux dff_mux_3(.D({SW[2], LEDR[2]^LEDR[1]}), .KEY(KEY), .Q(LEDR[2]));

endmodule

module dff_mux (
    input [1:0] D,
    input [1:0] KEY, // KEY[1] = L, KEY[0] = CLK
    output [0:0] Q);
    
    always @(posedge KEY[0]) begin
        Q <= D[KEY[1]];
    end
endmodule 
