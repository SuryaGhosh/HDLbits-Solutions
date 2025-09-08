module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    
    reg [1:0] current_state, next_state;
    
    always @ (*) begin
        case (current_state) 
            A: if (r[1] == 1'b1) begin
                   next_state = B; 
               end else if (r[2] == 1'b1) begin
                   next_state = C;
               end else if (r[3] == 1'b1) begin
                   next_state = D;
               end else begin
                   next_state = A;
               end
            B: if (r[1] == 1'b1) begin
                   next_state = B;
               end else begin
                   next_state = A;
               end
            C: if (r[2] == 1'b1) begin
                   next_state = C;
               end else begin
                   next_state = A;
               end
            D: if (r[3] == 1'b1) begin
                   next_state = D;
               end else begin
                   next_state = A;
               end
            default: next_state = A;
        endcase
    end
    
    always @ (posedge clk) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    assign g[3:1] = {current_state==D, current_state==C, current_state==B};
    

endmodule

