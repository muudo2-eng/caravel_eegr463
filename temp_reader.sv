module temp_reader(
input clk,
input reset,

input  [7:0] temp,
output reg [7:0] temperature,
output reg fever_flag);
always @(posedge clk)
begin 
    if (reset) begin
        fever_flag <= 0;
        temperature <= 0;
    end
    else  begin
        temperature <= temp;
        if (temp < 8'd25)
            fever_flag <= 1;
        else
            fever_flag <= 0;
    end
end


endmodule