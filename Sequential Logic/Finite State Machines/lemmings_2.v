module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT = 2'd0, RIGHT = 2'd1, FALL_L = 2'd2, FALL_R = 2'd3;
    reg [1:0] current_state, next_state;
    
    // next state logic 
    always @ (*) begin
        case (current_state)
            LEFT: if (ground == 1'b0)
                	next_state = FALL_L;
                  else 
          			next_state = bump_left;
            RIGHT: if (ground == 1'b0)
                    next_state = FALL_R;
            	  else 
                    next_state = !bump_right;
            FALL_L: if (ground == 1'b0)
                	next_state = FALL_L;
            		else 
                    next_state = LEFT;
            FALL_R: if (ground == 1'b0)
                    next_state = FALL_R;
            		else 
                    next_state = RIGHT;
            default: next_state = LEFT;
        endcase
    end
    
    // current state logic 
    always @ (posedge clk, posedge areset) begin
        if (areset) begin 
            current_state <= LEFT;
        end else begin
        	current_state <= next_state;
        end
    end
    
    // output logic 
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
    assign aaah = (current_state == FALL_L) + (current_state == FALL_R);
endmodule

