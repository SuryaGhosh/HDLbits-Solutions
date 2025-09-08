module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

	// transition logic
    // based on inputs and current state
    always @ (*) begin
        case (state) 
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default  next_state = A;
        endcase
    end

	// current state logic 
    // D: next state
    // Q: current state
    //always @ (posedge clk) begin
    //	state <= next_state;
    //end
    
    // output logic 
    // assign out = state....
    assign out = (state == D);

endmodule

