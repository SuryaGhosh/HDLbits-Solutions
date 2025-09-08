module top_module (
    input clk,
    input reset,        // synchronous, active-high
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);

    //This counter is fully programmable; that is, the outputs may be preset to either
    //level by placing a low on the load input and entering the desired data at the data inputs. 
    //It is for preloading the counter.

    assign c_load = (reset || (Q == 4'd12 && enable));          // load when Reset or Q == 12
    assign c_d = 4'd1;                                // always load 1
    assign c_enable = enable && !c_load;              // enable only if not loading

    
    // We are connecting the top_module to count4, we are feeding some of the inputs into
    // count4 from the outputs of top_module. Q, c_enable, c_load, and c_d from the top_module are driving count4
    
    // Instantiate internal counter
    count4 u_count4 (
        .clk(clk),
        .enable(c_enable),
        .load(c_load),
        .d(c_d),
        .Q(Q)
    );

endmodule
