module nrf24l01_controller (
    input wire clk,
    input wire reset,
    input wire [7:0] spi_rx_data,
    output reg [7:0] nrf_out,
    output reg [7:0] spi_tx_data,
    output reg spi_start,
    output reg spi_ce,
    input wire busy // From SPI master
);
    // State machine states
    localparam IDLE = 3'b000;
    localparam CONFIGURE = 3'b001;
    localparam TX_MODE = 3'b010;
    localparam RX_MODE = 3'b011;

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            nrf_out <= 8'b0;
            spi_tx_data <= 8'b0;
            spi_start <= 0;
            spi_ce <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (!busy) begin
                        state <= CONFIGURE; // Start configuration process.
                    end
                end

                CONFIGURE: begin
                 
                    spi_tx_data <= 8'h08; // CONFIG register value.
                    spi_start <= 1;

                    if (!busy) begin
                        state <= TX_MODE; // Move to TX mode after configuration.
                    end else begin
                        spi_start <= 0; // Wait for SPI transaction to complete.
                    end
                end

                TX_MODE: begin
                  
                    nrf_out <= spi_rx_data; // Capture received data.
                    state <= RX_MODE;       // Switch to RX mode.
                end

                RX_MODE: begin
                    // Example reception logic:
                    nrf_out <= spi_rx_data; // Process received data.
                    state <= IDLE;          // Return to idle after processing.
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
