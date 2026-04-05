module temp_uart_top (
    input clk,
    input reset,
    input [7:0] temp_input,
    output tx
);

wire baud_tick;
wire [7:0] temp_output;
wire fever_flag;
wire data_valid;
wire tx_request;
wire busy;

temp_reader temp_reader_inst (
    .clk(clk),
    .reset(reset),
    .temp_input(temp_input),
    .temp_output(temp_output),
    .fever_flag(fever_flag),
    .data_valid(data_valid),
    .tx_request(tx_request)
);

BaudTickGen baud_inst (
    .clk(clk),
    .reset(reset),
    .enable(1'b1),
    .tick(baud_tick)
);

uart_tx uart_inst (
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .start(tx_request & ~busy),
    .data(temp_output),
    .tx(tx),
    .busy(busy)
);

endmodule