module BaudTickGen (
    input clk,
    input reset,
    input enable,
    output reg tick
);

parameter integer ClkFrequency = 50000000;
parameter integer Baud = 115200;
localparam integer DIVISOR = ClkFrequency / Baud;

reg [15:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 16'd0;
        tick  <= 1'b0;
    end
    else if (enable) begin
        if (count == DIVISOR - 1) begin
            count <= 16'd0;
            tick  <= 1'b1;
        end
        else begin
            count <= count + 16'd1;
            tick  <= 1'b0;
        end
    end
    else begin
        count <= 16'd0;
        tick  <= 1'b0;
    end
end

endmodule