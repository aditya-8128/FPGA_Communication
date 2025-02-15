module nrf24l01_controller (
    input wire clk,
    input wire reset,
    input wire [7:0] spi_rx_data,
    output reg [7:0] nrf_out,
    output reg [7:0] spi_tx_data,
    output reg spi_start,
    output reg spi_ce,
    input wire spi_busy
);
    reg [3:0] state;

    // State definitions
    localparam IDLE       = 4'h0;
    localparam CONFIGURE  = 4'h1;
    localparam TX_MODE    = 4'h2;

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
                    if (!spi_busy) begin
                        state <= CONFIGURE; // Start configuration process
                    end
                end

                CONFIGURE: begin
                   
                    spi_tx_data <= 8'h08; 
                    spi_start <= 1;

                    if (!spi_busy) begin
                        state <= TX_MODE; // Move to TX mode after configuration.
                    end
                end

                TX_MODE: begin
                    // Example transmission logic:
                    nrf_out <= spi_rx_data; // Capture received data.
                    state <= IDLE;          // Return to IDLE after transmission.
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
