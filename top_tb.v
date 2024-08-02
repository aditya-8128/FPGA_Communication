// tb/top_tb.v

module top_tb;

reg clk;
reg reset;
reg spi_miso;
wire [7:0] nrf_out;
wire spi_sck;
wire spi_mosi;
wire spi_csn;
wire spi_ce;
wire clk2mhz;

top uut (
    .clk(clk),
    .reset(reset),
    .spi_miso(spi_miso),
    .nrf_out(nrf_out),
    .spi_sck(spi_sck),
    .spi_mosi(spi_mosi),
    .spi_csn(spi_csn),
    .spi_ce(spi_ce),
    .clk2mhz(clk2mhz)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    spi_miso = 0;
    #20 reset = 0;
   
end

endmodule
