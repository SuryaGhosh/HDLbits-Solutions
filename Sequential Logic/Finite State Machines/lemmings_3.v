module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    // state encodings
    parameter left = 3'd0, right = 3'd1, fall_left = 3'd2, fall_right = 3'd3, dig_left = 3'd4, dig_right = 3'd5;
    // states
    reg [2:0] current_state, next_state;
    
    // next state logic 
    // precedence: fall >> dig >> switch directions
    always @ (*) begin
        case (current_state)
            left: if (ground == 0)
                	next_state = fall_left;
                  else if (dig == 1)
                    next_state = dig_left;
                  else if (bump_left)
                    next_state = right;
                  else 
                    next_state = left;
            right: if (ground == 0)
                    next_state = fall_right;
                   else if (dig == 1)
                    next_state = dig_right;
            	   else if (bump_right)
                	next_state = left;
                   else 
                    next_state = right;
            fall_left: if (ground == 0)
                	next_state = fall_left;
            	   else if (ground == 1)
                    next_state = left;
            dig_left: if (ground == 0)
                    next_state = fall_left;
            		else if (ground == 1)
                    next_state = dig_left;
            fall_right: if (ground == 0)
                	next_state = fall_right;
                   else if (ground == 1)
                    next_state = right;
            dig_right: if (ground == 0)
                    next_state = fall_right;
            		else if (ground == 1)
                    next_state = dig_right;
            default: next_state = current_state;
        endcase
    end
    
    // current state logic
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            current_state <= left;
        end else begin
            current_state <= next_state;
        end
    end
    
    // output logic 
    assign walk_left = (current_state == left);
    assign walk_right = (current_state == right);
    assign aaah = ((current_state == fall_left) | (current_state == fall_right));
    assign digging = ((current_state == dig_left) | (current_state == dig_right));
    
endmodule

