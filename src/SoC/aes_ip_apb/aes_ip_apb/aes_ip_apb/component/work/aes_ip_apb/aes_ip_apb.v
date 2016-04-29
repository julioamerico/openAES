//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 06 12:04:00 2014
// Version: v11.3 11.3.0.112
//////////////////////////////////////////////////////////////////////

`timescale 1 ns/100 ps

// aes_ip_apb
module aes_ip_apb(
    // Inputs
    MAC_CRSDV,
    MAC_RXD,
    MAC_RXER,
    MSS_RESET_N,
    SPI_0_DI,
    UART_0_RXD,
    // Outputs
    EMC_AB,
    EMC_BYTEN,
    EMC_CLK,
    EMC_CS0_N,
    EMC_CS1_N,
    EMC_OEN0_N,
    EMC_OEN1_N,
    EMC_RW_N,
    MAC_MDC,
    MAC_TXD,
    MAC_TXEN,
    SPI_0_DO,
    UART_0_TXD,
    // Inouts
    EMC_DB,
    I2C_0_SCL,
    I2C_0_SDA,
    MAC_MDIO,
    SPI_0_CLK,
    SPI_0_SS
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         MAC_CRSDV;
input  [1:0]  MAC_RXD;
input         MAC_RXER;
input         MSS_RESET_N;
input         SPI_0_DI;
input         UART_0_RXD;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [25:0] EMC_AB;
output [1:0]  EMC_BYTEN;
output        EMC_CLK;
output        EMC_CS0_N;
output        EMC_CS1_N;
output        EMC_OEN0_N;
output        EMC_OEN1_N;
output        EMC_RW_N;
output        MAC_MDC;
output [1:0]  MAC_TXD;
output        MAC_TXEN;
output        SPI_0_DO;
output        UART_0_TXD;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  [15:0] EMC_DB;
inout         I2C_0_SCL;
inout         I2C_0_SDA;
inout         MAC_MDIO;
inout         SPI_0_CLK;
inout         SPI_0_SS;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [1:0]  aes_ip_0_dma_req;
wire          aes_ip_0_int_ccf;
wire          aes_ip_0_int_err;
wire          aes_ip_apb_MSS_0_FAB_CLK;
wire          aes_ip_apb_MSS_0_M2F_RESET_N;
wire          aes_ip_apb_MSS_0_MSS_MASTER_APB_PENABLE;
wire   [31:0] aes_ip_apb_MSS_0_MSS_MASTER_APB_PRDATA;
wire          aes_ip_apb_MSS_0_MSS_MASTER_APB_PREADY;
wire          aes_ip_apb_MSS_0_MSS_MASTER_APB_PSELx;
wire          aes_ip_apb_MSS_0_MSS_MASTER_APB_PSLVERR;
wire   [31:0] aes_ip_apb_MSS_0_MSS_MASTER_APB_PWDATA;
wire          aes_ip_apb_MSS_0_MSS_MASTER_APB_PWRITE;
wire   [31:0] CoreAPB3_0_APBmslave0_PADDR;
wire          CoreAPB3_0_APBmslave0_PENABLE;
wire   [31:0] CoreAPB3_0_APBmslave0_PRDATA;
wire          CoreAPB3_0_APBmslave0_PREADY;
wire          CoreAPB3_0_APBmslave0_PSELx;
wire          CoreAPB3_0_APBmslave0_PSLVERR;
wire   [31:0] CoreAPB3_0_APBmslave0_PWDATA;
wire          CoreAPB3_0_APBmslave0_PWRITE;
wire   [25:0] EMC_AB_net_0;
wire   [1:0]  EMC_BYTEN_net_0;
wire          EMC_CLK_net_0;
wire          EMC_CS0_N_net_0;
wire          EMC_CS1_N_net_0;
wire   [15:0] EMC_DB;
wire          EMC_OEN0_N_net_0;
wire          EMC_OEN1_N_net_0;
wire          EMC_RW_N_net_0;
wire          I2C_0_SCL;
wire          I2C_0_SDA;
wire          MAC_CRSDV;
wire          MAC_MDC_net_0;
wire          MAC_MDIO;
wire   [1:0]  MAC_RXD;
wire          MAC_RXER;
wire   [1:0]  MAC_TXD_net_0;
wire          MAC_TXEN_net_0;
wire          MSS_RESET_N;
wire          SPI_0_CLK;
wire          SPI_0_DI;
wire          SPI_0_DO_net_0;
wire          SPI_0_SS;
wire          UART_0_RXD;
wire          UART_0_TXD_net_0;
wire          EMC_CLK_net_1;
wire          EMC_CS0_N_net_1;
wire          EMC_CS1_N_net_1;
wire          EMC_OEN0_N_net_1;
wire          EMC_OEN1_N_net_1;
wire          EMC_RW_N_net_1;
wire   [25:0] EMC_AB_net_1;
wire   [1:0]  EMC_BYTEN_net_1;
wire          UART_0_TXD_net_1;
wire          SPI_0_DO_net_1;
wire          MAC_MDC_net_1;
wire   [1:0]  MAC_TXD_net_1;
wire          MAC_TXEN_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [31:0] IADDR_const_net_0;
wire   [31:0] PRDATAS1_const_net_0;
wire   [31:0] PRDATAS2_const_net_0;
wire   [31:0] PRDATAS3_const_net_0;
wire   [31:0] PRDATAS4_const_net_0;
wire   [31:0] PRDATAS5_const_net_0;
wire   [31:0] PRDATAS6_const_net_0;
wire   [31:0] PRDATAS7_const_net_0;
wire   [31:0] PRDATAS8_const_net_0;
wire   [31:0] PRDATAS9_const_net_0;
wire   [31:0] PRDATAS10_const_net_0;
wire   [31:0] PRDATAS11_const_net_0;
wire   [31:0] PRDATAS12_const_net_0;
wire   [31:0] PRDATAS13_const_net_0;
wire   [31:0] PRDATAS14_const_net_0;
wire   [31:0] PRDATAS15_const_net_0;
wire   [31:0] PRDATAS16_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:20]aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0_31to20;
wire   [19:0] aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0_19to0;
wire   [31:0] aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0;
wire   [19:0] aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net               = 1'b0;
assign VCC_net               = 1'b1;
assign IADDR_const_net_0     = 32'h00000000;
assign PRDATAS1_const_net_0  = 32'h00000000;
assign PRDATAS2_const_net_0  = 32'h00000000;
assign PRDATAS3_const_net_0  = 32'h00000000;
assign PRDATAS4_const_net_0  = 32'h00000000;
assign PRDATAS5_const_net_0  = 32'h00000000;
assign PRDATAS6_const_net_0  = 32'h00000000;
assign PRDATAS7_const_net_0  = 32'h00000000;
assign PRDATAS8_const_net_0  = 32'h00000000;
assign PRDATAS9_const_net_0  = 32'h00000000;
assign PRDATAS10_const_net_0 = 32'h00000000;
assign PRDATAS11_const_net_0 = 32'h00000000;
assign PRDATAS12_const_net_0 = 32'h00000000;
assign PRDATAS13_const_net_0 = 32'h00000000;
assign PRDATAS14_const_net_0 = 32'h00000000;
assign PRDATAS15_const_net_0 = 32'h00000000;
assign PRDATAS16_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign EMC_CLK_net_1    = EMC_CLK_net_0;
assign EMC_CLK          = EMC_CLK_net_1;
assign EMC_CS0_N_net_1  = EMC_CS0_N_net_0;
assign EMC_CS0_N        = EMC_CS0_N_net_1;
assign EMC_CS1_N_net_1  = EMC_CS1_N_net_0;
assign EMC_CS1_N        = EMC_CS1_N_net_1;
assign EMC_OEN0_N_net_1 = EMC_OEN0_N_net_0;
assign EMC_OEN0_N       = EMC_OEN0_N_net_1;
assign EMC_OEN1_N_net_1 = EMC_OEN1_N_net_0;
assign EMC_OEN1_N       = EMC_OEN1_N_net_1;
assign EMC_RW_N_net_1   = EMC_RW_N_net_0;
assign EMC_RW_N         = EMC_RW_N_net_1;
assign EMC_AB_net_1     = EMC_AB_net_0;
assign EMC_AB[25:0]     = EMC_AB_net_1;
assign EMC_BYTEN_net_1  = EMC_BYTEN_net_0;
assign EMC_BYTEN[1:0]   = EMC_BYTEN_net_1;
assign UART_0_TXD_net_1 = UART_0_TXD_net_0;
assign UART_0_TXD       = UART_0_TXD_net_1;
assign SPI_0_DO_net_1   = SPI_0_DO_net_0;
assign SPI_0_DO         = SPI_0_DO_net_1;
assign MAC_MDC_net_1    = MAC_MDC_net_0;
assign MAC_MDC          = MAC_MDC_net_1;
assign MAC_TXD_net_1    = MAC_TXD_net_0;
assign MAC_TXD[1:0]     = MAC_TXD_net_1;
assign MAC_TXEN_net_1   = MAC_TXEN_net_0;
assign MAC_TXEN         = MAC_TXEN_net_1;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0_31to20 = 12'h0;
assign aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0_19to0 = aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR[19:0];
assign aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0 = { aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0_31to20, aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0_19to0 };

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------aes_ip
aes_ip aes_ip_0(
        // Inputs
        .PADDR   ( CoreAPB3_0_APBmslave0_PADDR ),
        .PWDATA  ( CoreAPB3_0_APBmslave0_PWDATA ),
        .PWRITE  ( CoreAPB3_0_APBmslave0_PWRITE ),
        .PENABLE ( CoreAPB3_0_APBmslave0_PENABLE ),
        .PSEL    ( CoreAPB3_0_APBmslave0_PSELx ),
        .PCLK    ( aes_ip_apb_MSS_0_FAB_CLK ),
        .PRESETn ( aes_ip_apb_MSS_0_M2F_RESET_N ),
        // Outputs
        .int_ccf ( aes_ip_0_int_ccf ),
        .int_err ( aes_ip_0_int_err ),
        .dma_req ( aes_ip_0_dma_req ),
        .PREADY  ( CoreAPB3_0_APBmslave0_PREADY ),
        .PSLVERR ( CoreAPB3_0_APBmslave0_PSLVERR ),
        .PRDATA  ( CoreAPB3_0_APBmslave0_PRDATA ) 
        );

//--------aes_ip_apb_MSS
aes_ip_apb_MSS aes_ip_apb_MSS_0(
        // Inputs
        .UART_0_RXD  ( UART_0_RXD ),
        .SPI_0_DI    ( SPI_0_DI ),
        .MSS_RESET_N ( MSS_RESET_N ),
        .MAC_CRSDV   ( MAC_CRSDV ),
        .MAC_RXER    ( MAC_RXER ),
        .MAC_RXD     ( MAC_RXD ),
        .MSSPRDATA   ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PRDATA ),
        .MSSPREADY   ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PREADY ),
        .MSSPSLVERR  ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PSLVERR ),
        .DMAREADY    ( aes_ip_0_dma_req ),
        .F2M_GPI_31  ( aes_ip_0_int_ccf ),
        .F2M_GPI_30  ( aes_ip_0_int_err ),
        // Outputs
        .EMC_CLK     ( EMC_CLK_net_0 ),
        .EMC_CS0_N   ( EMC_CS0_N_net_0 ),
        .EMC_CS1_N   ( EMC_CS1_N_net_0 ),
        .EMC_OEN0_N  ( EMC_OEN0_N_net_0 ),
        .EMC_OEN1_N  ( EMC_OEN1_N_net_0 ),
        .EMC_RW_N    ( EMC_RW_N_net_0 ),
        .UART_0_TXD  ( UART_0_TXD_net_0 ),
        .SPI_0_DO    ( SPI_0_DO_net_0 ),
        .MAC_TXEN    ( MAC_TXEN_net_0 ),
        .MAC_MDC     ( MAC_MDC_net_0 ),
        .EMC_AB      ( EMC_AB_net_0 ),
        .EMC_BYTEN   ( EMC_BYTEN_net_0 ),
        .MAC_TXD     ( MAC_TXD_net_0 ),
        .FAB_CLK     ( aes_ip_apb_MSS_0_FAB_CLK ),
        .M2F_RESET_N ( aes_ip_apb_MSS_0_M2F_RESET_N ),
        .MSSPADDR    ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR ),
        .MSSPSEL     ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PSELx ),
        .MSSPENABLE  ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PENABLE ),
        .MSSPWRITE   ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PWRITE ),
        .MSSPWDATA   ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PWDATA ),
        // Inouts
        .SPI_0_CLK   ( SPI_0_CLK ),
        .SPI_0_SS    ( SPI_0_SS ),
        .I2C_0_SCL   ( I2C_0_SCL ),
        .I2C_0_SDA   ( I2C_0_SDA ),
        .MAC_MDIO    ( MAC_MDIO ),
        .EMC_DB      ( EMC_DB ) 
        );

//--------CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.0.100
CoreAPB3 #( 
        .APB_DWIDTH      ( 32 ),
        .APBSLOT0ENABLE  ( 1 ),
        .APBSLOT1ENABLE  ( 0 ),
        .APBSLOT2ENABLE  ( 0 ),
        .APBSLOT3ENABLE  ( 0 ),
        .APBSLOT4ENABLE  ( 0 ),
        .APBSLOT5ENABLE  ( 0 ),
        .APBSLOT6ENABLE  ( 0 ),
        .APBSLOT7ENABLE  ( 0 ),
        .APBSLOT8ENABLE  ( 0 ),
        .APBSLOT9ENABLE  ( 0 ),
        .APBSLOT10ENABLE ( 0 ),
        .APBSLOT11ENABLE ( 0 ),
        .APBSLOT12ENABLE ( 0 ),
        .APBSLOT13ENABLE ( 0 ),
        .APBSLOT14ENABLE ( 0 ),
        .APBSLOT15ENABLE ( 0 ),
        .IADDR_OPTION    ( 0 ),
        .MADDR_BITS      ( 16 ),
        .SC_0            ( 0 ),
        .SC_1            ( 0 ),
        .SC_2            ( 0 ),
        .SC_3            ( 0 ),
        .SC_4            ( 0 ),
        .SC_5            ( 0 ),
        .SC_6            ( 0 ),
        .SC_7            ( 0 ),
        .SC_8            ( 0 ),
        .SC_9            ( 0 ),
        .SC_10           ( 0 ),
        .SC_11           ( 0 ),
        .SC_12           ( 0 ),
        .SC_13           ( 0 ),
        .SC_14           ( 0 ),
        .SC_15           ( 0 ),
        .UPR_NIBBLE_POSN ( 3 ) )
CoreAPB3_0(
        // Inputs
        .PRESETN    ( GND_net ), // tied to 1'b0 from definition
        .PCLK       ( GND_net ), // tied to 1'b0 from definition
        .PADDR      ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PADDR_0 ),
        .PWRITE     ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PWRITE ),
        .PENABLE    ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PENABLE ),
        .PWDATA     ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PWDATA ),
        .PSEL       ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PSELx ),
        .PRDATAS0   ( CoreAPB3_0_APBmslave0_PRDATA ),
        .PREADYS0   ( CoreAPB3_0_APBmslave0_PREADY ),
        .PSLVERRS0  ( CoreAPB3_0_APBmslave0_PSLVERR ),
        .PRDATAS1   ( PRDATAS1_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS1   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS1  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS2   ( PRDATAS2_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS2   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS2  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS3   ( PRDATAS3_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS3   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS3  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS4   ( PRDATAS4_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS4   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS4  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS5   ( PRDATAS5_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS5   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS5  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS6   ( PRDATAS6_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS6   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS6  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS7   ( PRDATAS7_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS7   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS7  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS8   ( PRDATAS8_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS8   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS8  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS9   ( PRDATAS9_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS9   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS9  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS10  ( PRDATAS10_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS10  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS10 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS11  ( PRDATAS11_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS11  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS11 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS12  ( PRDATAS12_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS12  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS12 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS13  ( PRDATAS13_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS13  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS13 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS14  ( PRDATAS14_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS14  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS14 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS15  ( PRDATAS15_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS15  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS15 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS16  ( PRDATAS16_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS16  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS16 ( GND_net ), // tied to 1'b0 from definition
        .IADDR      ( IADDR_const_net_0 ), // tied to 32'h00000000 from definition
        // Outputs
        .PRDATA     ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PRDATA ),
        .PREADY     ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PREADY ),
        .PSLVERR    ( aes_ip_apb_MSS_0_MSS_MASTER_APB_PSLVERR ),
        .PADDRS     ( CoreAPB3_0_APBmslave0_PADDR ),
        .PWRITES    ( CoreAPB3_0_APBmslave0_PWRITE ),
        .PENABLES   ( CoreAPB3_0_APBmslave0_PENABLE ),
        .PWDATAS    ( CoreAPB3_0_APBmslave0_PWDATA ),
        .PSELS0     ( CoreAPB3_0_APBmslave0_PSELx ),
        .PSELS1     (  ),
        .PSELS2     (  ),
        .PSELS3     (  ),
        .PSELS4     (  ),
        .PSELS5     (  ),
        .PSELS6     (  ),
        .PSELS7     (  ),
        .PSELS8     (  ),
        .PSELS9     (  ),
        .PSELS10    (  ),
        .PSELS11    (  ),
        .PSELS12    (  ),
        .PSELS13    (  ),
        .PSELS14    (  ),
        .PSELS15    (  ),
        .PSELS16    (  ) 
        );


endmodule
