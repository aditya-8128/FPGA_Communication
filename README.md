# Wireless Communication System Between FPGA Boards

## Project Overview

I designed and implemented a wireless communication system between two FPGA boards using NRF24L01 RF modules and the SPI protocol. This project showcases my skills in FPGA design, RF communication, and Verilog programming, ensuring accurate and reliable data transmission and reception.


### Directory and File Descriptions

- `src/`
  - `spi_master.v`: Contains the Verilog code for the SPI master interface, which I developed to handle SPI communication with the NRF24L01 module.
  - `nrf24l01_controller.v`: Includes the Verilog code for controlling the NRF24L01 module. I designed this module to manage various states and configurations.
  - `top.v`: The top-level module that I created to integrate the SPI master and NRF24L01 controller modules, ensuring the overall communication system works seamlessly.

- `tb/`
  - `top_tb.v`: Testbench for the top-level module that I used to simulate and verify the functionality of the entire system.

## Detailed Description

### SPI Master Interface (`spi_master.v`)

I designed the SPI master interface to communicate with the NRF24L01 module using the SPI protocol. Key features of this interface include:
- Clock generation and management.
- Data shifting through SPI communication.
- Control signals for SPI communication such as `spi_sck`, `spi_mosi`, `spi_csn`, and `spi_ce`.

### NRF24L01 Controller (`nrf24l01_controller.v`)

The NRF24L01 controller, which I developed, handles the configuration and communication with the NRF24L01 RF module. The state machine within this module manages various states such as power on/off, configuration, and data transmission. Key features include:
- Configuration of NRF24L01 registers.
- Management of power states.
- Data payload handling for transmission.

### Top-Level Module (`top.v`)

The top-level module integrates the SPI master and NRF24L01 controller modules. I created this module to coordinate the overall communication system, ensuring seamless interaction between the SPI master and the RF module while managing data flow and control signals.

## Usage

### Simulation

To simulate the system and verify its functionality, I used the provided testbench `top_tb.v`. This testbench simulates the entire system, providing stimulus and observing the outputs.

### Synthesis

For synthesis, use the `top.v` module as the entry point. Ensure all Verilog source files are included in the project for successful synthesis and implementation on FPGA.

## Practical Experience

Through this project, I gained practical experience in:
- RF communication and FPGA interfacing.
- Power management, antenna integration, and error handling.
- Implementing and verifying SPI communication protocols.
- Configuring and controlling RF modules using Verilog.

## Conclusion

This project demonstrates my ability to design and implement a wireless communication system using FPGA and RF modules. By following the provided code and structure, I successfully created a robust and reliable communication system, gaining valuable skills in FPGA design and RF communication.


## Acknowledgements

I would like to thank the developers and contributors of the open-source tools and libraries used in this project.



