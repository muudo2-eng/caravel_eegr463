`timescale 1ps/1ps
module temp_reader_tb;

reg clk;
reg reset;
reg [7:0] temp;
wire [7:0] temperature; 
wire fever_flag;
 
temp_reader tr1 (.clk(clk), .reset(reset),.temp(temp),.temperature(temperature),.fever_flag(fever_flag));

always #25 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;
    #20 reset =0; 
    forever begin
    temp = 8'd01;
    #20 temp = 8'd25;
    #20 temp = 8'd35;
    #20 temp = 8'd50;    
    end
    
end
endmodule