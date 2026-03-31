module sar_adc (
    input wire clk,               // Clock input
    input wire rst,               // Reset input
    input wire comp_out,          // Comparator output (1 = vin > vdac, keep bit; 0 = vin < vdac, clear bit)
    output reg [15:0] digital_out, // 16-bit Digital output of ADC
    output reg EOC                // End of conversion signal
);

reg [15:0] sar_reg;   // SAR register
reg [3:0] state;     // State control
reg [3:0] i;         // Bit index (4 bits to safely hold 0–9)

// State definitions
localparam IDLE    = 0,
           INIT    = 1,
           COMPARE = 2,
           UPDATE  = 3,
           FINISH  = 4;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        sar_reg     <= 16'b0;
        digital_out <= 16'b0;
        state       <= IDLE;
        EOC         <= 0;
        i           <= 9;
    end else begin
        case (state)
            IDLE: begin
                sar_reg <= 16'b0;
                EOC     <= 0;       // Clear EOC at start of new conversion
                i       <= 9;
                state   <= INIT;
            end

            INIT: begin
                sar_reg[i] <= 1;    // Tentatively set current bit high
                state      <= COMPARE;
            end

            COMPARE: begin
                // Wait one cycle for comparator to settle
                state <= UPDATE;
            end

            UPDATE: begin
                if (comp_out == 0)
                    sar_reg[i] <= 0;  // Clear bit if DAC > Vin

                // Check BEFORE decrementing (non-blocking assignment race fix)
                if (i == 0)
                    state <= FINISH;
                else begin
                    i     <= i - 1;
                    state <= INIT;
                end
            end

            FINISH: begin
                digital_out <= sar_reg;  // Latch final result
                EOC         <= 1;
                state       <= IDLE;
            end

            default: state <= IDLE;
        endcase
    end
end

endmodule
