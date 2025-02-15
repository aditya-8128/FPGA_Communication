module spi_master (
    input wire clk,
    input wire reset,
    input wire [7:0] tx_data,
    input wire start,
    output reg [7:0] rx_data,
    output reg spi_sck,
    output reg spi_mosi,
    output reg spi_csn,
    input wire spi_miso
);
    reg [2:0] bit_counter;
    reg [7:0] tx_buffer;
    reg [7:0] rx_buffer;
    reg busy;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            spi_sck <= 0;
            spi_csn <= 1;
            spi_mosi <= 0;
            bit_counter <= 3'd7;
            busy <= 0;
        end else begin
            if (start && !busy) begin
                spi_csn <= 0;
                tx_buffer <= tx_data;
                busy <= 1;
                bit_counter <= 3'd7;
            end

            if (busy) begin
                spi_sck <= ~spi_sck;

                if (spi_sck) begin // Falling edge
                    spi_mosi <= tx_buffer[bit_counter];
                end else begin // Rising edge
                    rx_buffer[bit_counter] <= spi_miso;
                    if (bit_counter == 0) begin
                        busy <= 0;
                        spi_csn <= 1;
                        rx_data <= rx_buffer;
                    end else begin
                        bit_counter <= bit_counter - 1;
                    end
                end
            end
        end
    end
endmodule
