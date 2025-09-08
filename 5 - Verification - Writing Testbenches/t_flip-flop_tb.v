module top_module ();
    
    // inputs
    reg clk;
    reg reset;
    reg t;
    
    // outputs 
    wire q;
    
    // TFF module instantiation 
    tff u_tff(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );
    
    // resets TFF  
    initial begin
        reset = 0;
        # 10 reset = 1;
        # 10 reset = 0;
    end
    
    // drives t
    always @ (posedge clk) begin
        if (reset) begin
        	t <= 0;
        end else begin
        	t <= 1;
        end
    end
    
    
    // initializes clk and creates signal with 20ns period 
    initial clk = 0;
    always begin
        # 10 clk = ~clk;
    end
    
endmodule

