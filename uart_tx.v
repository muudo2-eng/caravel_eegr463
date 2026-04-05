module uart_tx (
    input clk,
    input reset,
    input baud_tick,
    input start,
    input [7:0] data,
    output reg tx,
    output reg busy
);

reg [7:0] data_reg;
reg [3:0] bit_index;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        tx <= 1'b1;
        busy <= 1'b0;
        bit_index <= 4'd0;
        data_reg <= 8'd0;
    end
    else begin
        if (!busy) begin
            tx <= 1'b1;
            if (start) begin
                busy <= 1'b1;
                data_reg <= data;
                bit_index <= 4'd0;
            end
        end
        else begin
            if (baud_tick) begin
                case (bit_index)
                    4'd0: tx <= 1'b0;
                    4'd1: tx <= data_reg[0];
                    4'd2: tx <= data_reg[1];
                    4'd3: tx <= data_reg[2];
                    4'd4: tx <= data_reg[3];
                    4'd5: tx <= data_reg[4];
                    4'd6: tx <= data_reg[5];
                    4'd7: tx <= data_reg[6];
                    4'd8: tx <= data_reg[7];
                    4'd9: tx <= 1'b1;
                    default: tx <= 1'b1;
                endcase

                if (bit_index == 4'd9) begin
                    busy <= 1'b0;
                    bit_index <= 4'd0;
                end
                else begin
                    bit_index <= bit_index + 4'd1;
                end
            end
        end
    end
end

endmodule