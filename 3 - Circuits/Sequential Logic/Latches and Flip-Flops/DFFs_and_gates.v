module top_module (
    input clk,
    input x,
    output z
); 
    wire [0:0] D1, D2, D3;
    reg [0:0] Q1, Q2, Q3; 
    
    // output
    assign z = ~(Q1 | Q2 | Q3);
    
    // wires/current state 
    assign D1 = x ^ Q1;
    assign D2 = x & ~Q2;
    assign D3 = x | ~Q3;
    
    // FFs/next state
    always @(posedge clk) begin
        Q1 <= D1;
        Q2 <= D2;
        Q3 <= D3; 
    end
endmodule

