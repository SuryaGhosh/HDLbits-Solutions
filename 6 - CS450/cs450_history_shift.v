module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    // Mealy FSM
    
    // state encodings
    parameter PREDICTED=2'd0, MISPREDICTED=2'd1, IDLE=2'd2;
    
    // current/next state 
    reg [1:0] current_state, next_state;
    
    // next state and output logic
    always @ (*) begin
        if (areset) begin
            next_state = IDLE;
        end else begin
            case (current_state) 
                IDLE: next_state = train_mispredicted ? MISPREDICTED : (predict_valid ? PREDICTED : IDLE);
                PREDICTED: next_state = train_mispredicted ? MISPREDICTED : (predict_valid ? PREDICTED : IDLE);
                MISPREDICTED: next_state = train_mispredicted ? MISPREDICTED : (predict_valid ? PREDICTED : IDLE);
                default : next_state = IDLE;
            endcase  
        end
    end
    
    // same logic as next state but updates predict_history reg on clk/areset posedge
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 32'b0;
        end else begin
        	case (current_state) 
                IDLE: 
                    if (train_mispredicted) begin
                        predict_history <= {train_history[30:0], train_taken};
                    end else if (predict_valid) begin
                        predict_history <= {predict_history[30:0], predict_taken};
                    end 
                PREDICTED:
                    if (train_mispredicted) begin
                        predict_history <= {train_history[30:0], train_taken};
                    end else if (predict_valid) begin
                        predict_history <= {predict_history[30:0], predict_taken};
                    end  
                MISPREDICTED:
                     if (train_mispredicted) begin
                        predict_history <= {train_history[30:0], train_taken};
                    end else if (predict_valid) begin
                        predict_history <= {predict_history[30:0], predict_taken};
                    end 
                default: predict_history <= predict_history;
            endcase
        end
    end
    
    // current state logic
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end   
endmodule
