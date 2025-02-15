module spi_master (
    input wire clk,
    input wire reset,
    input wire [7:0] tx_data,
    input wire start,
    output reg [7:0] rx_data,
    output reg spi_sck,
    output reg spi_mosi,
    output reg spi_csn,
    input wire spi_miso,
    output reg busy
);
    // State machine states
    localparam IDLE = 2'b00;
    localparam TRANSFER = 2'b01;
    localparam DONE = 2'b10;

    reg [1:0] state;
    reg [2:0] bit_counter;
    reg [7:0] tx_buffer;
    reg [7:0] rx_buffer;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            spi_sck <= 0;
            spi_csn <= 1;
            spi_mosi <= 0;
            busy <= 0;
            bit_counter <= 3'd7;
        end else begin
            case (state)
                IDLE: begin
                    busy <= 0;
                    spi_csn <= 1;
                    if (start) begin
                        tx_buffer <= tx_data;
                        bit_counter <= 3'd7;
                        state <= TRANSFER;
                        spi_csn <= 0; // Enable SPI device
                    end
                end

                TRANSFER: begin
                    busy <= 1;
                    spi_sck <= ~spi_sck; // Toggle clock

                    if (spi_sck == 0) begin // Falling edge: Send data
                        spi_mosi <= tx_buffer[bit_counter];
                    end else if (spi_sck == 1) begin // Rising edge: Receive data
                        rx_buffer[bit_counter] <= spi_miso;

                        if (bit_counter == 0) begin
                            state <= DONE;
                        end else begin
                            bit_counter <= bit_counter - 1;
                        end
                    end
                end

                DONE: begin
                    rx_data <= rx_buffer; // Capture received data
                    busy <= 0;
                    spi_csn <= 1; // Disable SPI device
                    state <= IDLE; // Return to idle state
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
