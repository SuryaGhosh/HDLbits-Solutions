//This counter will count from 0 to 9. It will also have a load function. Load will take precedence over enable
module bcd_counter(input clk, input reset, input [3:0] target, input [3:0] load,input enable,output reg [3:0] Q);
    always @(posedge clk) begin
        if (reset || (enable && Q == target)) begin 
            //If reset or if Q approaches the target while enabled, reset it to whatever the preset is. 
            Q <= load;
        end else if (enable) begin //If enabled, keep iterating the counter by 1.
            Q <= Q + 4'd1;
        end else Q <= Q; //Do nothing if not enabled or reset.
    end
endmodule
 
//Make a counter made up of 2 BCD counters. 
//The counter will reset to 0 when 59 and a flag will go high to iterate the next counter
 
module counter_59 (input clk, input reset, input enable, output reg [7:0] Q, output reg carryout);
    wire tensenable;
 
    assign carryout = (Q == 8'h59) && enable; //Carryout goes high when 59 while counter enabled, goes low otherwise.
 
    assign tensenable = (Q[3:0] == 4'd9) && enable; //Enable the tens counter when the ones place is 9 while counter enabled.
 
    bcd_counter tensplace(clk,reset,4'd5,4'd0,tensenable,Q[7:4]); //Iterate the counter when ones place is 9, then reset when 5.
    bcd_counter onesplace(clk,reset,4'd9,4'd0,enable,Q[3:0]); //Iterate the counter when enabled, reset when 9.
 
endmodule
 
module counter_12 (input clk, input reset, input enable, output reg [7:0] Q, output reg carryout);
    //Use a BCD counter. when ones place goes to 9, set tens place to 1. When Going to 12, set tens place to 0, tens place to 1
    initial begin 
        Q = 8'h12;
    end
    always @(posedge clk) begin
        if (enable) begin
            case (Q)
            8'h12:Q = 8'h01;
            8'h9: Q = 8'h10;
            default: Q = Q + 8'h1; 
        endcase 
        end
    end
 
    assign carryout = (Q == 8'h11 && enable); //Toggle the hours carryout when enabled and currently at 11, iterating to 12.
endmodule
 
module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
 
    //We will need to make a few BCD counters. You will also need to account for the following conditions:
 
    //11:59:59 ---> set to 12
    //12:59:59 ---> set to 1
 
    initial begin
        pm = 1'b0; //Always start the clock at AM on design startup
    end
 
 
    always @(posedge clk) begin
        if (hh == 8'h11 && hrs_carry) pm <= ~pm;
    end
    //Use two 59 counters for mins and secs. 
    wire mins_carry,secs_carry,hrs_carry;
    counter_59 secs(clk,reset,ena,ss,secs_carry);
    counter_59 mins(clk,reset,secs_carry,mm,mins_carry); //Enable mins when seconds is 59
 
    //Need a 1 to 12 counter. Use the submodule you created.
    counter_12 hrs(clk,reset,mins_carry,hh,hrs_carry);
endmodule
 

