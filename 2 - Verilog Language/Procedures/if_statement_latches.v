// synthesis verilog_input_version verilog_2001
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    always @(*) begin
        if (cpu_overheated == 1'b1) begin
           shut_off_computer = 1'b1;
        end 
        
        else begin
            shut_off_computer = 1'b0;
        end  
        
        if (arrived == 1'b1 || gas_tank_empty == 1'b1) begin
            keep_driving = 1'b0;
        end
        else begin 
            keep_driving = 1'b1;
        end
    end
endmodule

