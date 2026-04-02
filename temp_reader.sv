module temp_reader(
input clk,
input reset,

input  [7:0] temp,
output reg [7:0] temperature,
output reg fever_flag,
output reg data_valid,
output reg tx_request);
always @(posedge clk)
begin 
    data_valid <= 0;
    tx_request <= 0;
    if (reset) begin
        fever_flag <= 0;
        temperature <= 0; 
        

    end
    else  begin
        if (temp != temperature) begin
            data_valid <= 1;
            tx_request <= 1;
            temperature <= temp;
        end

        if (temp > 8'd98)
            fever_flag <= 1;
        else
            fever_flag <= 0;
    end
end


endmodule