module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [1:0] con1_selector;
    wire [15:0] con2, con3;
    
    add16 add16_1(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(con1_selector));
    add16 add16_2(.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(con2), .cout(1'b0));
    add16 add16_3(.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(con3), .cout(1'b0));
    
    always @(*) begin
        case (con1_selector)
            1'b0: sum[31:16] = con2;
            1'b1: sum[31:16] = con3;
            default: sum[31:16] = con2;
        endcase 
    end
endmodule

