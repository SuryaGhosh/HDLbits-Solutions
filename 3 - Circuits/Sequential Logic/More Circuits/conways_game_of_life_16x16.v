module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    integer x, y, xp, xm, yp, ym;
    reg [3:0] neighbors;
    reg [255:0] d;
    
    always @ (*) begin 
        for (x=0; x<16;++x) begin
            for (y=0; y<16; ++y) begin
                // adjusts xp, xm, yp, ym based on corner/edge cases
                if (x==1'd0) begin
                    xm = 4'd15;
                end else begin
                    xm = x-1'd1;
                end if (y==1'd0) begin
                    ym = 4'd15;
                end else begin
                    ym = y-1'd1;
                end if (x==4'd15) begin
                    xp = 4'd0;
                end else begin
                    xp = x+1'd1;
                end if (y==4'd15) begin
                    yp = 4'd0;
                end else begin
                    yp = y+1'd1;
                end
                
                // calculates total neighbors (8 directions)
                neighbors = q[x+yp*5'd16] + q[x+ym*5'd16] +
                			q[xp+y*5'd16] + q[xm+y*5'd16] + 
               	 			q[xp+yp*5'd16] + q[xm+ym*5'd16] +
                			q[xp+ym*5'd16] + q[xm+yp*5'd16];
                
                case (neighbors)
                    2: d[x+y*5'd16] = q[x+y*5'd16]; 
                    3: d[x+y*5'd16] = 1'd1;
                    default: d[x+y*5'd16] = 1'd0;
                endcase
            end
        end
    end
    
    always @ (posedge clk) begin
        if (load) begin
        	q <= data;
        end else begin
            q <= d;
        end
    end
endmodule

