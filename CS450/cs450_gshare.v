module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
); 

    // Pattern History Table: stores history of prediction confidence levels 
    reg [1:0] PHT [127:0]; 
    
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
        	// initialize/reset PHT to WNT 
            predict_history <= 7'b0;
            for (integer i=0; i<128; i=i+1) begin
                PHT[i] <= 2'b01;
            end
        end else begin
            // training requested, updates PHT 
            if (train_valid) begin 
                // change path taken strength  
                if (train_taken) begin
                    // increment PHT
                    PHT[train_history^train_pc] <= PHT[train_history^train_pc] == 2'b11 ? 2'b11 : PHT[train_history^train_pc] + 1'b1;
                end else begin
                    // decrement PHT
                    PHT[train_history^train_pc] <= PHT[train_history^train_pc] == 2'b00 ? 2'b00 : PHT[train_history^train_pc] - 1'b1;
                end  
            end 
            
            // training is requested, and a misprediction has taken place
            if (train_valid && train_mispredicted) begin
                // amend correct history with correct prediction 
                predict_history <= {train_history[6:0], train_taken};
            end else if (predict_valid) begin 
                // otherwise, add new prediction to predicted history
                predict_history <= {predict_history[6:0], predict_taken};
            end
        end        
    end
    
    // return the predicted taken path, access it from the PHT through the 1st bit in an entry (0th bit is strength, 1st bit is T/NT) 
    assign predict_taken = PHT[predict_history ^ predict_pc][1];

endmodule

