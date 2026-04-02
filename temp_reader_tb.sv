`timescale 1ps/1ps
module temp_reader_tb;

reg clk;
reg reset;
reg [7:0] temp;
wire [7:0] temperature; 
wire fever_flag;
wire data_valid;
wire tx_request;
 
temp_reader tr1 (.clk(clk), .reset(reset),.temp(temp),.temperature(temperature),.fever_flag(fever_flag),.data_valid(data_valid),.tx_request(tx_request));

always #25 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;
    #40 reset =0; 
  forever begin
    temp = 8'd01;
    #35  temp = 8'd95;
    #55  temp = 8'd96;
    #45  temp = 8'd97;
    #65  temp = 8'd98;
    #40  temp = 8'd99;
    #70  temp = 8'd100;
    #50  temp = 8'd101;
    #60  temp = 8'd102;
    #45  temp = 8'd103;
    #55;
end
    
end
endmodule