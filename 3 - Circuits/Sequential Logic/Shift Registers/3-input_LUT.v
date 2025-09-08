module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
	
    reg [7:0] mux_input;
    shift_register_8_bit shift_register(.S(S), .enable(enable), .clk(clk), .Q(mux_input));
    
    // 3-bit MUX, inputs: Q, sel: {A,B,C}
    
    assign Z = mux_input[{A,B,C}];
    
endmodule

// shift register is a bank of D-FFs that shifts in the MSB and shifts out the LSB
module shift_register_8_bit (
    input [0:0] S,
    input [0:0] enable,
    input [0:0] clk,
    output [7:0] Q);
    
    always @(posedge clk) begin
        if (enable == 1'b1) begin
            Q <= {Q[6:0],S}; //check
        end else begin
            Q <= Q;
        end
    end    
endmodule

