module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    // Q connects the modules 
    
    MUX_DFF mux_dff_4(.clk(KEY[0]), .w(KEY[3]), .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[3]));
    MUX_DFF mux_dff_3(.clk(KEY[0]), .w(LEDR[3]), .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[2]));
    MUX_DFF mux_dff_2(.clk(KEY[0]), .w(LEDR[2]), .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[1]));
    MUX_DFF mux_dff_1(.clk(KEY[0]), .w(LEDR[1]), .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[0]));

endmodule

module MUX_DFF (
    input clk,
    input w, R, E, L,
    output Q
);
    wire [0:0] w1, w2;
    
    always @(*) begin   
        w1 = E ? w : Q;
        w2 = L ? R : w1;
    end
    
    always @(posedge clk) begin
        Q <= w2;
    end
endmodule


