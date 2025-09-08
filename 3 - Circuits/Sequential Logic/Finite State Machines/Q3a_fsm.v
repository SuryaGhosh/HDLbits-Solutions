// Used the following repository for guidance
// https://gitee.com/mosqlwj/Solutions-to-HDLbits-Verilog-sets/blob/master/3.circuits/sequential%20logic/142.Q3A_fsm.v

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=1'd0, B=1'd1; 
 
    reg [2:0] w_count, cycle_count;
    reg [3:0] current_state, next_state;
 
    // next state logic
    always @(*) begin
        case (current_state) 
            A  : next_state = s ? B : A;
            B  : next_state = B;
        endcase
    end
 
    // current state logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
        	current_state <= next_state;
        end
    end 
 
    // tracks w frequency and clock cycle
    always @(posedge clk) begin
        if (reset) begin
        	cycle_count <= 1'd0;
            w_count <= 3'd0;
        end else begin
            if (current_state == B) begin
                w_count <= {w_count[1:0], w};
            end
            if (next_state == B) begin
                if (cycle_count == 2'd3) begin
                    cycle_count <= 1'd1;
                end else begin
                    cycle_count <= cycle_count + 1'd1;
                end
            end
        end 
    end
 
    assign z = (cycle_count == 2'd1) * ((w_count == 3'b011) | (w_count == 3'b101) | (w_count == 3'b110));
endmodule
 

