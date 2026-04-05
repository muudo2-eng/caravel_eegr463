module temp_reader(
    input clk,
    input reset,

    input [7:0] temp_input,
    output reg [7:0] temp_output,
    output reg fever_flag,
    output reg data_valid,
    output reg tx_request
);

always @(posedge clk)
begin
    data_valid <= 0;
    tx_request <= 0;

    if (reset) begin
        fever_flag <= 0;
        temp_output <= 0;
    end
    else begin
        if (temp_input != temp_output) begin
            data_valid <= 1;
            tx_request <= 1;
            temp_output <= temp_input;
        end

        if (temp_input > 8'd98)
            fever_flag <= 1;
        else
            fever_flag <= 0;
    end
end

endmodule