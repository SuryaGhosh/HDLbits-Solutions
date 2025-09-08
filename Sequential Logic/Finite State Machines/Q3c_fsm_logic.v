module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    
    // next state logic 
    always @ (*) begin
        case (y) 
        	3'b000 : Y0 = x ? 1'b1 : 1'b0;  
            3'b001 : Y0 = x ? 1'b0 : 1'b1;
            3'b010 : Y0 = x ? 1'b1 : 1'b0;
            3'b011 : Y0 = x ? 1'b0 : 1'b1;
            3'b100 : Y0 = x ? 1'b0 : 1'b1;
            default: Y0 = Y0;
        endcase
    end
   
    // output logic 
    assign z = (y == 3'b011) + (y == 3'b100);
    
endmodule

