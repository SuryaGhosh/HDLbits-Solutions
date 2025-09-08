module top_module ( );
    reg clk; 
    initial clk=0; // clk begins at 0 
    
    always begin
        #5 clk = ~clk; // toggles clk every 5 ns
    end
    
    // dut module initialization
    dut dut1(
        .clk(clk)
    );
endmodule

