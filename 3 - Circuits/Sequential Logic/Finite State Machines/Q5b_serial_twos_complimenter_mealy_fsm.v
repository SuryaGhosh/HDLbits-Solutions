module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=2'b01, B=2'b10;
    reg [1:0] next_state, current_state;
    
    always @ (*) begin
        case (current_state)
            A : begin
                next_state = x ? B : A;
                z = x ? 1'd1 : 1'd0;
            end
            B: begin
                next_state = B;
                z = x ? 1'd0 : 1'd1;
            end
        endcase
    end
    
    always @ (posedge clk, posedge areset) begin
        if (areset == 1'd1) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

endmodule

