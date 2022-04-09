/**************************************************************************************************/
/**** RVSoC (Mini Kuroda/RISC-V)                       since 2018-08-07   ArchLab. TokyoTech   ****/
/**** main module for Implemetaion v0.13                                                       ****/
/**************************************************************************************************/
`default_nettype none
/**************************************************************************************************/
`include "define.vh"

/**************************************************************************************************/
module m_main#(
               parameter APP_ADDR_WIDTH  = 28,
               parameter APP_CMD_WIDTH   = 3,
               parameter APP_DATA_WIDTH  = 128,  // Note
               parameter APP_MASK_WIDTH  = 16)
    (

     input  wire        CLK, // board bare clock

     output wire        core_clk_div2_out,
     input  wire        w_rxd,
     output wire        w_txd,

     output wire [15:0] w_led,
     output reg   [7:0] r_sg,
     output reg   [7:0] r_an,

     output wire        w_led1_B,
     output wire        w_led1_G,
     output wire        w_led1_R,

     input wire w_locked,

     input wire ui_clk,
     input wire ui_rst,
     input wire init_calib_complete,

     input wire CORE_CLK,
     input wire RST_X2,

     output wire [3:0] s_axi_awid,
     output wire [APP_ADDR_WIDTH-1:0] s_axi_awaddr,
     output wire [7:0] s_axi_awlen,
     output wire [2:0] s_axi_awsize,
     output wire [1:0] s_axi_awburst,
     output wire [0:0] s_axi_awlock,
     output wire [3:0] s_axi_awcache,
     output wire [2:0] s_axi_awprot,
     output wire [3:0] s_axi_awqos,
     output wire s_axi_awvalid,
     input wire s_axi_awready,

     output wire [APP_DATA_WIDTH-1:0] s_axi_wdata,
     output wire [APP_MASK_WIDTH-1:0] s_axi_wstrb,
     output wire s_axi_wlast,
     output wire s_axi_wvalid,
     input wire s_axi_wready,

     input wire [3:0] s_axi_bid,
     input wire [1:0] s_axi_bresp,
     input wire s_axi_bvalid,
     output wire s_axi_bready,

     output wire [3:0] s_axi_arid,
     output wire [APP_ADDR_WIDTH-1:0] s_axi_araddr,
     output wire [7:0] s_axi_arlen,
     output wire [2:0] s_axi_arsize,
     output wire [1:0] s_axi_arburst,
     output wire [0:0] s_axi_arlock,
     output wire [3:0] s_axi_arcache,
     output wire [2:0] s_axi_arprot,
     output wire [3:0] s_axi_arqos,
     output wire s_axi_arvalid,
     input wire s_axi_arready,

     input wire [3:0] s_axi_rid,
     input wire [APP_DATA_WIDTH-1:0] s_axi_rdata,
     input wire [1:0] s_axi_rresp,
     input wire s_axi_rlast,
     input wire s_axi_rvalid,
     output wire s_axi_rready
     );

    wire RST_X_IN = 1;
    wire w_btnu = 0;
    wire w_btnd = 0;
    wire w_btnl = 0;
    wire w_btnr = 0;
    wire w_btnc = 0;
    wire [15:0] w_sw = 0;

    wire [15:0] w_led_t; // temporal w_led


    reg [31:0] r_cnt=0;
    reg        r_time_led=0;
    always@(posedge CORE_CLK) r_cnt <= (r_cnt>=(64*1000000/2-1)) ? 0 : r_cnt+1;
    always@(posedge CORE_CLK) r_time_led <= (r_cnt==0) ? !r_time_led : r_time_led;

    assign w_led[0] = r_time_led;
    assign w_led[1] = w_init_done;
    assign w_led[2] = w_data_we;
    assign w_led[3] = w_busy;
    assign w_led[15:4] = 0;
    
    /*******************************************************************************/
    reg         r_stop = 0;
    reg  [63:0] r_core_cnt = 0;

    // Connection Core <--> mem_ctrl
    wire [31:0] w_insn_data, w_insn_addr;
    wire [31:0] w_data_data, w_data_wdata, w_data_addr;
    wire        w_data_we;
    wire  [2:0] w_data_ctrl;

    wire [31:0] w_priv, w_satp, w_mstatus;
    wire [63:0] w_mtime, w_mtimecmp, w_wmtimecmp;
    wire        w_clint_we;
    wire [31:0] w_mip, w_wmip;
    wire        w_plic_we;
    wire        w_busy;
    wire [31:0] w_pagefault;
    wire  [1:0] w_tlb_req;
    wire        w_tlb_flush;
    wire        w_init_done;
    wire        w_init_stage;

    // Reset
    wire RST        = ~w_locked;
    wire RST_X      = ~RST & RST_X2;
    wire CORE_RST_X = RST_X & w_init_done;

    // 7seg
    wire [31:0] w_core_odata;
    wire [31:0] w_core_pc, w_core_ir;
    wire [31:0] w_7seg_data = (w_btnu) ? r_core_cnt[41:10] : (w_btnd) ? w_checksum : (w_btnc) ? w_mtimecmp :
                (w_btnl) ? w_core_pc  : (w_btnr) ? w_core_ir : w_mtime[41:10];
    wire w_init_start;
    reg         r_load = 0;
    always@(posedge CORE_CLK) begin
        if(r_load==0 && w_init_start && !w_init_done) r_load <= 1;
        else if(w_init_done) r_load <= 0;
    end

    wire  [7:0] w_sg;
    wire  [7:0] w_an;
    m_7segcon m_7segcon(CORE_CLK, CORE_RST_X, r_load, w_7seg_data, w_sg, w_an);
    always @(posedge CORE_CLK) begin
        r_sg <= w_sg;
        r_an <= w_an;
    end

    // Uart
    wire  [7:0] w_uart_data;
    wire        w_uart_we;
    wire [31:0] w_checksum;

    wire w_finish;
    wire w_halt;

    // stop and count
    always@(posedge CORE_CLK) begin
        if(w_btnc | w_halt | w_finish) r_stop <= 1;
        if(w_init_done && !r_stop && w_led_t[9:8] == 0) r_core_cnt <= r_core_cnt + 1;
    end

    m_mmu#(.APP_ADDR_WIDTH(APP_ADDR_WIDTH),
           .APP_CMD_WIDTH(APP_CMD_WIDTH),
           .APP_DATA_WIDTH(APP_DATA_WIDTH),
           .APP_MASK_WIDTH(APP_MASK_WIDTH))
    c(
        .CLK            (CORE_CLK),
        .RST_X          (RST_X),
        .w_insn_addr    (w_insn_addr),
        .w_data_addr    (w_data_addr),
        .w_data_wdata   (w_data_wdata),
        .w_data_we      (w_data_we),
        .w_data_ctrl    (w_data_ctrl),
        .w_insn_data    (w_insn_data),
        .w_data_data    (w_data_data),
        .r_finish       (w_finish),
        .w_priv         (w_priv),
        .w_satp         (w_satp),
        .w_mstatus      (w_mstatus),
        .w_mtime        (w_mtime),
        .w_mtimecmp     (w_mtimecmp),
        .w_wmtimecmp    (w_wmtimecmp),
        .w_clint_we     (w_clint_we),
        .w_mip          (w_mip),
        .w_wmip         (w_wmip),
        .w_plic_we      (w_plic_we),
        .w_proc_busy    (w_busy),
        .w_pagefault    (w_pagefault),
        .w_tlb_req      (w_tlb_req),
        .w_tlb_flush    (w_tlb_flush),
        .w_txd          (w_txd),
        .w_rxd          (w_rxd),
        .w_init_done    (w_init_done),

        // input clk, rst (active-low)
        .ui_clk(ui_clk),
	.ui_rst(ui_rst),
	.init_calib_complete(init_calib_complete),

	.s_axi_awid                     (s_axi_awid),
	.s_axi_awaddr                   (s_axi_awaddr),
	.s_axi_awlen                    (s_axi_awlen),
	.s_axi_awsize                   (s_axi_awsize),
	.s_axi_awburst                  (s_axi_awburst),
	.s_axi_awlock                   (s_axi_awlock),
	.s_axi_awcache                  (s_axi_awcache),
	.s_axi_awprot                   (s_axi_awprot),
	.s_axi_awqos                    (s_axi_awqos),
	.s_axi_awvalid                  (s_axi_awvalid),
	.s_axi_awready                  (s_axi_awready),
	// Slave Interface Write Data Ports
	.s_axi_wdata                    (s_axi_wdata),
	.s_axi_wstrb                    (s_axi_wstrb),
	.s_axi_wlast                    (s_axi_wlast),
	.s_axi_wvalid                   (s_axi_wvalid),
	.s_axi_wready                   (s_axi_wready),
	// Slave Interface Write Response Ports
	.s_axi_bid                      (s_axi_bid),
	.s_axi_bresp                    (s_axi_bresp),
	.s_axi_bvalid                   (s_axi_bvalid),
	.s_axi_bready                   (s_axi_bready),
	// Slave Interface Read Address Ports
	.s_axi_arid                     (s_axi_arid),
	.s_axi_araddr                   (s_axi_araddr),
	.s_axi_arlen                    (s_axi_arlen),
	.s_axi_arsize                   (s_axi_arsize),
	.s_axi_arburst                  (s_axi_arburst),
	.s_axi_arlock                   (s_axi_arlock),
	.s_axi_arcache                  (s_axi_arcache),
	.s_axi_arprot                   (s_axi_arprot),
	.s_axi_arqos                    (s_axi_arqos),
	.s_axi_arvalid                  (s_axi_arvalid),
	.s_axi_arready                  (s_axi_arready),
	// Slave Interface Read Data Ports
	.s_axi_rid                      (s_axi_rid),
	.s_axi_rdata                    (s_axi_rdata),
	.s_axi_rresp                    (s_axi_rresp),
	.s_axi_rlast                    (s_axi_rlast),
	.s_axi_rvalid                   (s_axi_rvalid),
	.s_axi_rready                   (s_axi_rready),

        // clk, rst (active-low)
        .core_clk       (CORE_CLK),
        .core_rst_x     (RST_X2),

        .w_uart_data    (w_uart_data),
        .w_uart_we      (w_uart_we),
        .w_led          (w_led_t),
        .w_init_stage   (w_init_stage),
        .w_checksum     (w_checksum),
        .w_debug_btnd   (w_btnd)
        //.w_baud         (w_sw[15:14]),
        //.w_init_start   (w_init_start)
    );

    m_RVCoreM p(
        .CLK            (CORE_CLK),
        .RST_X          (CORE_RST_X),
        .w_stall        (r_stop),
        .r_halt         (w_halt),
        .w_insn_addr    (w_insn_addr),
        .w_data_addr    (w_data_addr),
        .w_insn_data    (w_insn_data),
        .w_data_data    (w_data_data),
        .w_data_wdata   (w_data_wdata),
        .w_data_we      (w_data_we),
        .w_data_ctrl    (w_data_ctrl),
        .w_priv         (w_priv),
        .w_satp         (w_satp),
        .w_mstatus      (w_mstatus),
        .w_mtime        (w_mtime),
        .w_mtimecmp     (w_mtimecmp),
        .w_wmtimecmp    (w_wmtimecmp),
        .w_clint_we     (w_clint_we),
        .w_mip          (w_mip),
        .w_wmip         (w_wmip),
        .w_plic_we      (w_plic_we),
        .w_busy         (w_busy),
        .w_pagefault    (w_pagefault),
        .w_tlb_req      (w_tlb_req),
        .w_tlb_flush    (w_tlb_flush),
        .w_core_pc      (w_core_pc),
        .w_core_ir      (w_core_ir),
        .w_core_odata   (w_core_odata),
        .w_init_stage   (w_init_stage)
    );

/*********** Chika Chika **************************/
    reg  r_led1_B=0,r_led1_G=0,r_led1_R=0;

    reg  [12:0] r_cnt_B=0, r_cnt_G=64, r_cnt_R=512;
    reg  [11:0] r_ctrl_cnt = 0;
    reg   [3:0] r_blite_cnt = 0;
    always@(posedge CLK) begin
        r_ctrl_cnt <= r_ctrl_cnt + 1;
        r_blite_cnt <= r_blite_cnt + 1;
        if(r_ctrl_cnt == 0) begin
            r_cnt_B <= r_cnt_B + 2;
            r_cnt_G <= r_cnt_G + 3;
            r_cnt_R <= r_cnt_R + 5;
        end
        r_led1_B <= r_cnt_B[12] ? (r_cnt_B[11:0] < r_ctrl_cnt) : (r_cnt_B[11:0] >= r_ctrl_cnt);
        r_led1_G <= r_cnt_G[12] ? (r_cnt_G[11:0] < r_ctrl_cnt) : (r_cnt_G[11:0] >= r_ctrl_cnt);
        r_led1_R <= r_cnt_R[12] ? (r_cnt_R[11:0] < r_ctrl_cnt) : (r_cnt_R[11:0] >= r_ctrl_cnt);
    end
    wire [2:0] t_led = {r_led1_B, r_led1_G, r_led1_R};
    // User blue, SuperVisor Green or Yellow, Machine, Error -> Red
    assign {w_led1_B,w_led1_G,w_led1_R} =   (w_sw[0]) ? 0 :
                                            (w_led_t[3:0] == 4'b0001) ? {r_led1_B, r_led1_G, r_led1_R} :
                                            (!w_init_done) ? 0 :
                                            (r_blite_cnt != 0) ? 0 :
                                            (w_priv == `PRIV_U) ? 3'b001 :
                                            (w_priv == `PRIV_S) ? 3'b010 :
                                            (w_priv == `PRIV_M) ? 3'b100 : 0;

    reg core_clk_div2 = 0;
    always @(posedge CORE_CLK) begin
	core_clk_div2 <= ~core_clk_div2;
    end
    assign core_clk_div2_out = core_clk_div2;

endmodule

/**************************************************************************************************/
module m_7segled (w_in, r_led);
    input  wire [3:0] w_in;
    output reg  [7:0] r_led;
    always @(*) begin
        case (w_in)
        4'h0  : r_led <= 8'b01111110;
        4'h1  : r_led <= 8'b00110000;
        4'h2  : r_led <= 8'b01101101;
        4'h3  : r_led <= 8'b01111001;
        4'h4  : r_led <= 8'b00110011;
        4'h5  : r_led <= 8'b01011011;
        4'h6  : r_led <= 8'b01011111;
        4'h7  : r_led <= 8'b01110000;
        4'h8  : r_led <= 8'b01111111;
        4'h9  : r_led <= 8'b01111011;
        4'ha  : r_led <= 8'b01110111;
        4'hb  : r_led <= 8'b00011111;
        4'hc  : r_led <= 8'b01001110;
        4'hd  : r_led <= 8'b00111101;
        4'he  : r_led <= 8'b01001111;
        4'hf  : r_led <= 8'b01000111;
        default:r_led <= 8'b00000000;
        endcase
    end
endmodule

`define DELAY7SEG  16000 // 200000 for 100MHz, 100000 for 50MHz -> 16000 for 8MHz
/**************************************************************************************************/
module m_7segcon(w_clk, w_rst_x, w_load, w_din, r_sg, r_an);
    input  wire w_clk, w_rst_x, w_load;
    input  wire [31:0] w_din;
    output reg [7:0] r_sg;  // cathode segments
    output reg [7:0] r_an;  // common anode

    reg [31:0] r_val   = 0;
    reg [31:0] r_cnt   = 0;
    reg  [3:0] r_in    = 0;
    reg  [2:0] r_digit = 0;
    always@(posedge w_clk) r_val <= w_din;

    // For RVSoc_1
    `define r_7seg_A 8'b01110111
    `define r_7seg_r 8'b00000101
    `define r_7seg_c 8'b00001101
    `define r_7seg_h 8'b00010111
    `define r_7seg_P 8'b01100111
    `define r_7seg_o 8'b00011101

    // For Loading
    `define r_7seg_L 8'b00001110
    `define r_7seg_a 8'b01111101
    `define r_7seg_d 8'b00111101
    `define r_7seg_i 8'b00010000
    `define r_7seg_n 8'b00010101
    `define r_7seg_g 8'b11111011

    reg  [7:0] r_init   = 8'b00000000;
    reg  [7:0] r_load   = 8'b00000000;

    reg  [7:0] r_load_mem [0:15];
    integer i;
    initial begin
        r_load_mem[0] = 0;
        r_load_mem[1] = 0;
        r_load_mem[2] = 0;
        r_load_mem[3] = 0;
        r_load_mem[4] = 0;
        r_load_mem[5] = 0;
        r_load_mem[6] = 0;
        r_load_mem[7] = `r_7seg_L;
        r_load_mem[8] = `r_7seg_o;
        r_load_mem[9] = `r_7seg_a;
        r_load_mem[10] = `r_7seg_d;
        r_load_mem[11] = `r_7seg_i;
        r_load_mem[12] = `r_7seg_n;
        r_load_mem[13] = `r_7seg_g;
        r_load_mem[14] = 8'b10000000;
        r_load_mem[15] = 8'b10000000;
    end

//    reg[104:0] r_load_tmp = {49'b0, `r_7seg_L, `r_7seg_o, `r_7seg_a, `r_7seg_d, `r_7seg_i, `r_7seg_n, `r_7seg_g, 14'b0};
    reg [24:0] r_load_cnt = 0;
    reg  [3:0] r_lcnt = 0;
    always@(posedge w_clk) begin
        if(w_load) r_load_cnt <= r_load_cnt + 1;
        if(w_load && (r_load_cnt == 0)) r_lcnt <= r_lcnt + 1;//r_load_tmp <= r_load_tmp << 7;
    end

    always@(posedge w_clk) begin
        r_cnt <= (r_cnt>=(`DELAY7SEG-1)) ? 0 : r_cnt + 1;
        if(r_cnt==0) begin
        r_digit <= r_digit+ 1;
        if      (r_digit==0) begin r_an <= 8'b11111110; r_in <= r_val[3:0]  ; r_init = `r_7seg_c; r_load = r_load_mem[r_lcnt+7]; end
        else if (r_digit==1) begin r_an <= 8'b11111101; r_in <= r_val[7:4]  ; r_init = `r_7seg_o; r_load = r_load_mem[r_lcnt+6]; end
        else if (r_digit==2) begin r_an <= 8'b11111011; r_in <= r_val[11:8] ; r_init = `r_7seg_r; r_load = r_load_mem[r_lcnt+5]; end
        else if (r_digit==3) begin r_an <= 8'b11110111; r_in <= r_val[15:12]; r_init = `r_7seg_P; r_load = r_load_mem[r_lcnt+4]; end
        else if (r_digit==4) begin r_an <= 8'b11101111; r_in <= r_val[19:16]; r_init = `r_7seg_h; r_load = r_load_mem[r_lcnt+3]; end
        else if (r_digit==5) begin r_an <= 8'b11011111; r_in <= r_val[23:20]; r_init = `r_7seg_c; r_load = r_load_mem[r_lcnt+2]; end
        else if (r_digit==6) begin r_an <= 8'b10111111; r_in <= r_val[27:24]; r_init = `r_7seg_r; r_load = r_load_mem[r_lcnt+1]; end
        else                 begin r_an <= 8'b01111111; r_in <= r_val[31:28]; r_init = `r_7seg_A; r_load = r_load_mem[r_lcnt];   end
        end
    end
    wire [7:0] w_segments;
    m_7segled m_7segled (r_in, w_segments);
    always@(posedge w_clk) r_sg <= (w_load) ? ~r_load : (w_rst_x) ? ~w_segments : ~r_init;
endmodule
/**************************************************************************************************/

// A E F J L P U H Y O 

// A r c h P r o c
