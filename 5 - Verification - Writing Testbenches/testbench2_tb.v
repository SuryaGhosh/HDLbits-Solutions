module top_module();
    reg clk;
    reg in;
    reg [2:0] s;
    reg out;
    
    q7 u_q7 (clk, in, s, out);
    
    // clk waveform
    initial clk=0;    
	always begin
        #5
        clk = ~clk;
    end
    
    // in waveform 
    initial begin
        in = 0;
        # 20 in = 1;
        # 10 in = 0;
        # 10 in = 1;
        # 30 in = 0;
    end
    
    // s waveform 
    initial begin
    	s = 2;
        # 10 s = 6;
        # 10 s = 2;
        # 10 s = 7;
        # 10 s = 0;
    end
endmodule

