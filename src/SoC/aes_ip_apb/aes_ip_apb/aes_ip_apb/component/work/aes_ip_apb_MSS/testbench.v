//////////////////////////////////////////////////////////////////////
// Created by Actel SmartDesign Sun Jul 06 12:03:58 2014
// Testbench Template
// This is a basic testbench that instantiates your design with basic 
// clock and reset pins connected.  If your design has special
// clock/reset or testbench driver requirements then you should 
// copy this file and modify it. 
//////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module testbench;

parameter SYSCLK_PERIOD = 100; // 10MHz

reg SYSCLK;
reg NSYSRESET;

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 10 )
        NSYSRESET = 1'b1;
end


//////////////////////////////////////////////////////////////////////
// 10MHz Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  aes_ip_apb_MSS
//////////////////////////////////////////////////////////////////////
aes_ip_apb_MSS aes_ip_apb_MSS_0 (
    // Inputs
    .MSSPREADY({1{1'b0}}),
    .MSSPSLVERR({1{1'b0}}),
    .F2M_GPI_31({1{1'b0}}),
    .F2M_GPI_30({1{1'b0}}),
    .MSSPRDATA({32{1'b0}}),
    .DMAREADY({2{1'b0}}),
    .UART_0_RXD({1{1'b0}}),
    .SPI_0_DI({1{1'b0}}),
    .MAC_RXD({2{1'b0}}),
    .MAC_CRSDV({1{1'b0}}),
    .MAC_RXER({1{1'b0}}),
    .MSS_RESET_N(NSYSRESET),

    // Outputs
    .FAB_CLK( ),
    .M2F_RESET_N( ),
    .MSSPSEL( ),
    .MSSPENABLE( ),
    .MSSPWRITE( ),
    .MSSPADDR( ),
    .MSSPWDATA( ),
    .UART_0_TXD( ),
    .SPI_0_DO( ),
    .EMC_AB( ),
    .EMC_BYTEN( ),
    .EMC_CS0_N( ),
    .EMC_CS1_N( ),
    .EMC_OEN0_N( ),
    .EMC_OEN1_N( ),
    .EMC_CLK( ),
    .EMC_RW_N( ),
    .MAC_TXD( ),
    .MAC_TXEN( ),
    .MAC_MDC( ),

    // Inouts
    .SPI_0_CLK( ),
    .SPI_0_SS( ),
    .I2C_0_SDA( ),
    .I2C_0_SCL( ),
    .EMC_DB( ),
    .MAC_MDIO( )

);

endmodule

