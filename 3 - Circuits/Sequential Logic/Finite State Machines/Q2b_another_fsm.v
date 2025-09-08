module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    parameter A=4'd0, f0=4'd1, X0=4'd2, X1=4'd3, X2=4'd4, G0=4'd5, G1=4'd6, G2=4'd7, G3=4'd8;
    reg [3:0] current_state, next_state;
    
    // next state logic
    always @ (*) begin
        case (current_state)
            A  : next_state = resetn ? f0 : A;
            f0 : next_state = X0;
            X0 : next_state = x ? X1 : X0;
            X1 : next_state = x ? X1 : X2;
            X2 : next_state = x ? G0 : X0;
            G0 : next_state = y ? G1 : G2;
            G1 : next_state = G1;
            G2 : next_state = y ? G1 : G3;
            G3 : next_state = G3;
            default: next_state = A;
        endcase
    end
    
    // current state logic
    always @ (posedge clk) begin
        if (!resetn) begin
            current_state <= A;
        end else begin 
            current_state <= next_state;
        end
    end
    
    // output logic
    assign f = (current_state == f0);
    assign g = ((current_state == G0) + (current_state == G1) + (current_state == G2));
    
    

endmodule

