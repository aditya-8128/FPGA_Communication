module top (
    input wire clk,
    input wire reset,
    input wire spi_miso,
    output wire [7:0] nrf_out,
    output wire spi_sck,
    output wire spi_mosi,
    output wire spi_csn,
    output wire spi_ce
);
    wire [7:0] spi_tx_data, spi_rx_data;
    wire spi_start, spi_busy;

    nrf24l01_controller nrf_ctrl (
        .clk(clk),
        .reset(reset),
        .spi_rx_data(spi_rx_data),
        .nrf_out(nrf_out),
        .spi_tx_data(spi_tx_data),
        .spi_start(spi_start),
        .spi_ce(spi_ce),
        .spi_busy(spi_busy)
    );

    spi_master spi (
        .clk(clk),
        .reset(reset),
        .tx_data(spi_tx_data),
        .start(spi_start),
        .rx_data(spi_rx_data),
        .spi_sck(spi_sck),
        .spi_mosi(spi_mosi),
        .spi_csn(spi_csn),
        .spi_miso(spi_miso)
    );

endmodule
