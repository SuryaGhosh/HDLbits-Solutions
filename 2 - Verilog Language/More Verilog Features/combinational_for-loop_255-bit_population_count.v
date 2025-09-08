module top_module( 
    input reg [254:0] in,
    output reg [7:0] out );
    
       
    always @ (*) begin
        out = 0;
        for (integer i=0; i < 255; i++) begin // shouldn't use $size because it's not real hardware 
            if (in[i] == 1'b1)
                out = out + 1'b1;
        end
    end
endmodule

