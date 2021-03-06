/**************************************************************************************************/
/**** RVSoC (Mini Kuroda/RISC-V)                       since 2018-08-07   ArchLab. TokyoTech   ****/
/**** Memory Controller v0.01                                                                  ****/
/**************************************************************************************************/
`default_nettype none
/**************************************************************************************************/
`include "define.vh"

/**************************************************************************************************/
module m_mmu#(
              parameter APP_ADDR_WIDTH  = 28,
              parameter APP_CMD_WIDTH   = 3,
              parameter APP_DATA_WIDTH  = 128,  // Note
              parameter APP_MASK_WIDTH  = 16)
    (
     input  wire         CLK, RST_X,
     input  wire [31:0]  w_insn_addr, w_data_addr,
     input  wire [31:0]  w_data_wdata,
     input  wire         w_data_we,
     input  wire  [2:0]  w_data_ctrl,
     output wire [31:0]  w_insn_data, w_data_data,
     output reg          r_finish,
     input  wire [31:0]  w_priv, w_satp, w_mstatus,
     input  wire [63:0]  w_mtime, w_mtimecmp,
     output wire [63:0]  w_wmtimecmp,
     output wire         w_clint_we,
     input  wire [31:0]  w_mip,
     output wire [31:0]  w_wmip,
     output wire         w_plic_we,
     output wire         w_proc_busy,
     output wire [31:0]  w_pagefault,
     input  wire  [1:0]  w_tlb_req,
     input  wire         w_tlb_flush,
     output wire         w_txd,
     input  wire         w_rxd,
     output wire         w_init_done,

     input wire ui_clk,
     input wire ui_rst,
     input wire init_calib_complete,

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
     output wire s_axi_rready,

     input wire         core_clk,
     input wire         core_rst_x,
     output wire  [7:0]  w_uart_data,
     output wire         w_uart_we,
     output wire [15:0]  w_led,
     input  wire         w_init_stage,
     output wire [31:0]  w_checksum,
     input  wire         w_debug_btnd
     //    input  wire  [1:0]  w_baud,
     //    output wire         w_init_start
     );

    initial r_finish = 0;

    /***** Address translation ********************************************************************/
    reg  [31:0] physical_addr       = 0;
    reg         page_walk_fail      = 0;

    // Page walk state
    reg  [2:0]  r_pw_state          = 0;

    // Page table entry
    reg  [31:0] L1_pte              = 0;
    reg  [31:0] L0_pte              = 0;

    /***** Other Registers ************************************************************************/
    // Device checker
    reg   [3:0] r_dev               = 0;
    reg   [3:0] r_virt              = 0;

    // TO HOST
    reg  [31:0] r_tohost            = 0;

    // PLIC
    reg  [31:0] plic_served_irq     = 0;
    reg  [31:0] plic_pending_irq    = 0;
    reg  [31:0] r_plic_odata        = 0;

    // CLINT
    reg  [31:0] r_clint_odata       = 0;

    /***** Micro Controller ***********************************************************************/
    reg   [1:0] r_mc_mode           = 0;
    reg  [31:0] r_mc_qnum           = 0;
    reg  [31:0] r_mc_qsel           = 0;

    reg  [31:0] r_mc_done           = 0;

    /***** Keyboard Input *************************************************************************/
    reg   [3:0] r_consf_head        = 0;  // Note!!
    reg   [3:0] r_consf_tail        = 0;  // Note!!
    reg   [4:0] r_consf_cnts        = 0;  // Note!!
    reg         r_consf_en          = 0;
    reg   [7:0] cons_fifo [0:15];

`ifdef SIM_MODE
    initial begin
        r_consf_en = 1;
        cons_fifo[0] = 8'h72;  // "r"
        cons_fifo[1] = 8'h6f;  // "o"
        cons_fifo[2] = 8'h6f;  // "o"
        cons_fifo[3] = 8'h74;  // "t"
        cons_fifo[4] = 8'hd;   // "(CR)"
        cons_fifo[5] = 8'hd;   // "(CR)"
        cons_fifo[6] = 8'h74;  // "t"
        cons_fifo[7] = 8'h6f;  // "o"
        cons_fifo[8] = 8'h70;  // "p"
        cons_fifo[9] = 8'hd;   // "(CR)"
        r_consf_tail = 10;
        r_consf_cnts = 10;
    end
`endif

    /**********************************************************************************************/
    // dram data
    wire [31:0] w_dram_odata;

    wire        w_tlb_busy;
    wire        w_dram_busy;

    wire [31:0] w_mc_addr;
    wire [31:0] w_mc_wdata;
    wire        w_mc_we;
    wire  [2:0] w_mc_ctrl;
    wire  [1:0] w_mc_aces;

    wire [31:0] w_mem_wdata = (r_mc_mode!=0) ? w_mc_wdata  : w_data_wdata;
    wire        w_mem_we    = (r_mc_mode!=0) ? w_mc_we     : w_data_we;


    /***********************************        Page walk       ***********************************/
    wire        w_iscode        = (w_tlb_req == `ACCESS_CODE);
    wire        w_isread        = (w_tlb_req == `ACCESS_READ);
    wire        w_iswrite       = (w_tlb_req == `ACCESS_WRITE);
    wire [31:0] v_addr          = w_iscode ? w_insn_addr : w_data_addr;

    // Level 1
    wire [31:0] vpn1            = {22'b0, v_addr[31:22]};
    wire [31:0] L1_pte_addr     = {w_satp[19:0], 12'b0} + {vpn1, 2'b0};
    wire  [2:0] L1_xwr          = w_mstatus[19] ? (L1_pte[3:1] | L1_pte[5:3]) : L1_pte[3:1];
    wire [31:0] L1_paddr        = {L1_pte[29:10], 12'h0};
    wire [31:0] L1_p_addr       = {L1_paddr[31:22], v_addr[21:0]};
    wire        L1_write        = !L1_pte[6] || (!L1_pte[7] && w_iswrite);
    wire        L1_success      = !(L1_xwr ==2 || L1_xwr == 6 ||
                                    (w_priv == `PRIV_S && (L1_pte[4] && !w_mstatus[18])) ||
                                    (w_priv == `PRIV_U && !L1_pte[4]) ||
                                    (L1_xwr[w_tlb_req] == 0));

    // Level 0
    wire [31:0] vpn0            = {22'b0, v_addr[21:12]};
    wire [31:0] L0_pte_addr     = {L1_pte[29:10], 12'b0} + {vpn0, 2'b0};
    wire  [2:0] L0_xwr          = w_mstatus[19] ? (L0_pte[3:1] | L0_pte[5:3]) : L0_pte[3:1];
    wire [31:0] L0_paddr        = {L0_pte[29:10], 12'h0};
    wire [31:0] L0_p_addr       = {L0_paddr[31:12], v_addr[11:0]};
    wire        L0_write        = !L0_pte[6] || (!L0_pte[7] && w_iswrite);
    wire        L0_success      = !(L0_xwr ==2 || L0_xwr == 6 ||
                                    (w_priv == `PRIV_S && (L0_pte[4] && !w_mstatus[18])) ||
                                    (w_priv == `PRIV_U && !L0_pte[4]) ||
                                    (L0_xwr[w_tlb_req] == 0));

    // update pte
    wire [31:0] L1_pte_write    = L1_pte | `PTE_A_MASK | (w_iswrite ? `PTE_D_MASK : 0);
    wire [31:0] L0_pte_write    = L0_pte | `PTE_A_MASK | (w_iswrite ? `PTE_D_MASK : 0);
    wire        w_pte_we        = (r_pw_state==5) && (((L1_xwr != 0 && L1_success) && L1_write) ||
                                        ((L0_xwr != 0 && L0_success) && L0_write));
    wire [31:0] w_pte_waddr     = (L1_xwr != 0 && L1_success) ? L1_pte_addr : L0_pte_addr;
    wire [31:0] w_pte_wdata     = (L1_xwr != 0 && L1_success) ? L1_pte_write : L0_pte_write;

    assign w_pagefault          = !page_walk_fail ? ~32'h0 : (w_iscode) ? `CAUSE_FETCH_PAGE_FAULT :
                                    (w_isread) ? `CAUSE_LOAD_PAGE_FAULT : `CAUSE_STORE_PAGE_FAULT;

    reg  [31:0] r_tlb_addr = 0;
    reg   [2:0] r_tlb_use  = 0;
    wire [21:0] w_tlb_inst_r_addr, w_tlb_data_r_addr, w_tlb_data_w_addr;
    wire        w_tlb_inst_r_oe, w_tlb_data_r_oe, w_tlb_data_w_oe;
    wire        w_use_tlb = (r_mc_mode==0 && (w_iscode || w_isread || w_iswrite)
                                          && (!(w_priv == `PRIV_M || w_satp[31] == 0)));
    wire        w_tlb_hit = ((w_iscode && w_tlb_inst_r_oe) ||
                            (w_isread && w_tlb_data_r_oe)  ||
                            (w_iswrite && w_tlb_data_w_oe));

    // PAGE WALK state
    always@(posedge CLK) begin
        if(r_pw_state == 0) begin
            // PAGE WALK START
            if(!w_dram_busy && w_use_tlb) begin
                // tlb miss
                if(!w_tlb_hit) begin
                    r_pw_state <= 1;
                end
                else begin
                    r_pw_state <= 7;
                    case ({w_iscode, w_isread, w_iswrite})
                        3'b100 : r_tlb_addr <= {w_tlb_inst_r_addr[21:2], w_insn_addr[11:0]};
                        3'b010 : r_tlb_addr <= {w_tlb_data_r_addr[21:2], w_data_addr[11:0]};
                        3'b001 : r_tlb_addr <= {w_tlb_data_w_addr[21:2], w_data_addr[11:0]};
                        default: r_tlb_addr <= 0;
                    endcase
                    r_tlb_use <= {w_iscode, w_isread, w_iswrite};
                end
            end
        end
        // Level 1
        else if(r_pw_state == 1 && !w_dram_busy) begin
            L1_pte      <= w_dram_odata;
            r_pw_state  <= 2;
        end
        else if(r_pw_state == 2) begin
            r_pw_state  <= 3;
        end
        // Level 0
        else if(r_pw_state == 3 && !w_dram_busy) begin
            L0_pte      <= w_dram_odata;
            r_pw_state  <= 4;
        end
        // Success?
        else if(r_pw_state == 4) begin
            if(!L1_pte[0]) begin
                physical_addr   <= 0;
                page_walk_fail  <= 1;
            end
            else if(L1_xwr) begin
                physical_addr   <= (L1_success) ? L1_p_addr : 0;
                page_walk_fail  <= (L1_success) ? 0 : 1;
            end
            else if(!L0_pte[0]) begin
                physical_addr   <= 0;
                page_walk_fail  <= 1;
            end
            else if(L0_xwr) begin
                physical_addr   <= (L0_success) ? L0_p_addr : 0;
                page_walk_fail  <= (L0_success) ? 0 : 1;
            end
            r_pw_state  <= 5;
        end
        // Update pte
        else if(r_pw_state == 5) begin
            r_pw_state      <= 0;
            physical_addr   <= 0;
            page_walk_fail  <= 0;
        end
        else if(r_pw_state == 7) begin
            r_pw_state <= 0;
            r_tlb_use <= 0;
            //$write("hoge!, %x, %x\n", page_walk_fail, r_tlb_use);
        end
    end
    
    /***********************************           TLB          ***********************************/
    wire        w_tlb_inst_r_we   = (r_pw_state == 5 && !page_walk_fail && w_iscode);
    wire        w_tlb_data_r_we   = (r_pw_state == 5 && !page_walk_fail && w_isread);
    wire        w_tlb_data_w_we   = (r_pw_state == 5 && !page_walk_fail && w_iswrite);
    wire [21:0] w_tlb_wdata       = {physical_addr[31:12], 2'b0};

    m_tlb#(20, 22, `TLB_SIZE) TLB_inst_r (CLK, 1'b1, w_tlb_flush, w_tlb_inst_r_we,
                                            w_insn_addr[31:12], w_insn_addr[31:12], w_tlb_wdata,
                                            w_tlb_inst_r_addr, w_tlb_inst_r_oe);

    m_tlb#(20, 22, `TLB_SIZE) TLB_data_r (CLK, 1'b1, w_tlb_flush, w_tlb_data_r_we,
                                            w_data_addr[31:12], w_data_addr[31:12], w_tlb_wdata,
                                            w_tlb_data_r_addr, w_tlb_data_r_oe);

    m_tlb#(20, 22, `TLB_SIZE) TLB_data_w (CLK, 1'b1, w_tlb_flush, w_tlb_data_w_we,
                                            w_data_addr[31:12], w_data_addr[31:12], w_tlb_wdata,
                                            w_tlb_data_w_addr, w_tlb_data_w_oe);

    /***********************************          Memory        ***********************************/
    reg  [31:0] r_tlb_pte_addr = 0;
    reg         r_tlb_acs = 0;
    always@(*)begin
        case (r_pw_state)
            0:      begin r_tlb_pte_addr <= L1_pte_addr;    r_tlb_acs = 1; end
            2:      begin r_tlb_pte_addr <= L0_pte_addr;    r_tlb_acs = 1; end
            5:      begin r_tlb_pte_addr <= w_pte_waddr;    r_tlb_acs = 1; end
            default:begin r_tlb_pte_addr <= 0;              r_tlb_acs = 0; end
        endcase
    end

    //wire w_tlb_i_use = w_tlb_inst_r_oe && w_iscode;
    //wire w_tlb_r_use = w_tlb_data_r_oe && w_isread;
    //wire w_tlb_w_use = w_tlb_data_w_oe && w_iswrite;
    /*wire [31:0] w_tlb_data_addr = (w_tlb_w_use) ?   {w_tlb_data_w_addr[21:2], w_data_addr[11:0]} :
                                                    {w_tlb_data_r_addr[21:2], w_data_addr[11:0]};*/


    wire [31:0] w_insn_paddr =  (w_priv == `PRIV_M || w_satp[31] == 0) ? w_insn_addr :
                                r_tlb_addr;

    wire [31:0] w_mem_paddr  =  (r_mc_mode != 0)                        ? w_mc_addr     :
                                (w_priv == `PRIV_M || w_satp[31] == 0)  ? w_data_addr   : r_tlb_addr;
//                                (r_pw_state == 5)                       ? r_tlb_addr    :
//                                (r_tlb_acs)                             ? r_tlb_pte_addr:
//                                                                          w_data_addr;

    wire [2:0]  w_mem_ctrl   =  (r_mc_mode != 0)                        ? w_mc_ctrl         :
                                (w_priv == `PRIV_M || w_satp[31] == 0)  ? w_data_ctrl       :
                                (r_tlb_use[1:0]!=0)                     ? w_data_ctrl       :
                                (r_pw_state == 0)                       ? `FUNCT3_LW____    :
                                (r_pw_state == 2)                       ? `FUNCT3_LW____    :
                                (r_pw_state == 5)                       ? `FUNCT3_SW____    :
                                w_data_ctrl;

    wire  [3:0] w_dev       = w_mem_paddr[31:28];// & 32'hf0000000;
    wire  [3:0] w_virt      = w_mem_paddr[27:24];// & 32'h0f000000;
    wire [27:0] w_offset    = w_mem_paddr & 28'h7ffffff;

    //always@(posedge CLK) w_virt <= w_mem_paddr & 32'h0f000000;

    wire [31:0] w_dram_wdata    = (r_pw_state == 5) ? w_pte_wdata : w_mem_wdata;
    wire        w_dram_we       = (w_mem_we && !w_tlb_busy
                                    && (w_dev == `MEM_BASE_TADDR || w_dev == 0));

    wire [31:0] w_dram_addr =   (r_mc_mode!=0)              ? w_mc_addr         :
                                (w_iscode && !w_tlb_busy)   ? w_insn_paddr      :
                                (w_priv == `PRIV_M || w_satp[31] == 0) ? w_data_addr :
                                (r_tlb_acs && !w_tlb_hit)   ? r_tlb_pte_addr    : w_mem_paddr;

    wire [2:0]  w_dram_ctrl =   (r_mc_mode!=0)              ? (w_mem_ctrl)      :
                                (w_iscode && !w_tlb_busy)   ? `FUNCT3_LW____    : w_mem_ctrl;
    assign      w_insn_data =   w_dram_odata;

    wire        w_dram_aces = (w_dram_addr[31:28] == 8 || w_dram_addr[31:28] == 0 || w_dram_addr[31:28] == 9);

    wire        w_dram_le   =
                    (w_dram_busy)  ? 0 :
                    (!w_dram_aces) ? 0 :
                    (r_mc_mode!=0) ? (w_mc_aces==`ACCESS_READ && w_mc_addr[31:28] != 0) :
                    (w_priv == `PRIV_M || w_satp[31] == 0) ? (w_iscode || w_isread) :
                    (r_tlb_use[2:1]!=0) ? 1 :
                    (w_tlb_busy && !w_tlb_hit && (r_pw_state == 0 || r_pw_state==2)) ? 1 : 0;


    /***********************************         Console        ***********************************/
    wire        w_cons_we   = (r_mc_mode != 0) ? (w_mem_we && w_mem_paddr[31:12] == 20'h4000a) :
                            (w_mem_we && !w_tlb_busy && w_dev == `VIRTIO_BASE_TADDR && w_virt == 0);
    wire [31:0] w_cons_data;
    wire [31:0] w_cons_addr = (r_mc_mode != 0) ? w_mem_paddr : {4'b0, w_offset};
    wire        w_cons_req;
    wire [31:0] w_cons_qnum;
    wire [31:0] w_cons_qsel;

    /***********************************           Disk         ***********************************/
    wire        w_disk_we   = (r_mc_mode != 0) ? (w_mem_we && w_mem_paddr[31:12] == 20'h4000b) :
                            (w_mem_we && !w_tlb_busy && w_dev == `VIRTIO_BASE_TADDR && w_virt != 0);
    wire [31:0] w_disk_data;
    wire [31:0] w_disk_addr = (r_mc_mode != 0) ? w_mem_paddr : {4'b0, w_offset};
    wire        w_disk_req;
    wire [31:0] w_disk_qnum;
    wire [31:0] w_disk_qsel;


    /***********************************           image        ***********************************/
//    wire        w_imag_we       = w_mem_we && r_mc_mode != 0 && w_dram_addr[31:28] == 4'h9;
    wire        w_imag_we       = w_mem_we && r_mc_mode != 0 && w_mem_paddr[31:28] == 4'h9;
    
    /***********************************          OUTPUT        ***********************************/
    reg  [31:0] r_data_data = 0;
    always@(*) begin
        case (r_dev)
            `CLINT_BASE_TADDR : r_data_data <= r_clint_odata;
            `PLIC_BASE_TADDR  : r_data_data <= r_plic_odata;
            `VIRTIO_BASE_TADDR: r_data_data <= (r_virt == 0) ? w_cons_data : w_disk_data;
            default           : r_data_data <= w_dram_odata;
        endcase
    end
    assign w_data_data = r_data_data;
    /*assign      w_data_data =   (r_dev == `CLINT_BASE_TADDR)    ? r_clint_odata     :
                                (r_dev == `PLIC_BASE_TADDR)     ? r_plic_odata      :
                                (r_dev == `VIRTIO_BASE_TADDR)   ?
                                    ((r_virt == 0) ? w_cons_data : w_disk_data) : w_dram_odata;*/

    /***********************************          VirtIO        ***********************************/
    wire        w_key_we;
    wire  [7:0] w_key_data;
    wire        w_key_req = r_consf_en && (w_mtime > `ENABLE_TIMER + 64'd1000000) && ((w_mtime & 64'h3ffff) == 0)
                            && r_mc_mode == 0 && w_init_stage;
    reg         r_key_we    = 0;
    reg   [7:0] r_key_data  = 0;
    always@(posedge CLK) begin
        r_key_we    <= w_key_we;
        r_key_data  <= w_key_data;
    end

    always@(posedge CLK) begin
        if(r_mc_done) begin
            r_mc_mode <= 0;
            r_mc_done <= 0;
            if(r_mc_mode==3) begin
//`ifdef SIM_MODE
//                r_consf_en <= 1;
//                r_consf_head <= (r_consf_head < 8) ? r_consf_head + 1 : r_consf_head;
//`else
                r_consf_en <= (r_consf_cnts<=1) ? 0 : 1;
                r_consf_head <= r_consf_head + 1;
                r_consf_cnts <= r_consf_cnts - 1;
//`endif
            end
        end
        else if(r_key_we) begin
            if(r_consf_cnts < 16) begin
                cons_fifo[r_consf_tail] <= r_key_data;
                r_consf_tail            <= r_consf_tail + 1;
                r_consf_cnts            <= r_consf_cnts + 1;
                r_consf_en              <= 1;
            end
        end
        else begin
            case ({w_cons_req, w_disk_req, w_key_req})
                3'b100: begin
                    r_mc_mode <= 1;
                    r_mc_qnum <= w_cons_qnum;
                    r_mc_qsel <= w_cons_qsel;
                end
                3'b010: begin
                    r_mc_mode <= 2;
                    r_mc_qnum <= w_disk_qnum;
                    r_mc_qsel <= w_disk_qsel;
                end
                3'b001: begin
                    r_mc_mode <= 3;
                    r_mc_qnum <= w_cons_qnum;
                    r_mc_qsel <= 0;
                end
            endcase
        end
        /*else if(w_cons_req) begin
            r_mc_mode <= 1;
            r_mc_qnum <= w_cons_qnum;
            r_mc_qsel <= w_cons_qsel;
        end
        else if(w_disk_req) begin
            r_mc_mode <= 2;
            r_mc_qnum <= w_disk_qnum;
            r_mc_qsel <= w_disk_qsel;
        end
        else if(w_key_req) begin
            r_mc_mode <= 3;
            r_mc_qnum <= w_cons_qnum;
            r_mc_qsel <= 0;
        end*/
        if(r_tohost[31:16]==`CMD_POWER_OFF) begin
            r_mc_done <= 1;
        end

    end

    reg  [31:0] r_mc_arg = 0;
    always@(*) begin
        case (w_mem_paddr[31:12])
            20'h40009: begin
                case (w_mem_paddr[3:0])
                    4: r_mc_arg <= r_mc_qnum;
                    8: r_mc_arg <= r_mc_qsel;
                    default: r_mc_arg <= r_mc_mode;
                endcase
            end
            20'h4000a: r_mc_arg <= w_cons_data;
            20'h4000b: r_mc_arg <= w_disk_data;
            20'h4000c: r_mc_arg <= cons_fifo[r_consf_head];
            default:   r_mc_arg <= w_dram_odata;
        endcase
    end

    wire [31:0] w_mc_arg = r_mc_arg;
    /*wire [31:0] w_mc_arg =  (w_mem_paddr == `MODE_ADDR)        ? r_mc_mode                  :
                            (w_mem_paddr == `QNUM_ADDR)        ? r_mc_qnum                  :
                            (w_mem_paddr == `QSEL_ADDR)        ? r_mc_qsel                  :
                            (w_mem_paddr[31:12] == `CONQ_ADDR) ? w_cons_data                :
                            (w_mem_paddr[31:12] == `DISQ_ADDR) ? w_disk_data                : 
                            (w_mem_paddr == `KEYQ_ADDR)        ? cons_fifo[r_consf_head]    :
                            w_dram_odata;*/

    wire [31:0] w_cons_irq, w_disk_irq;
    wire        w_cons_irq_oe, w_disk_irq_oe;
    wire        w_isdisk        = w_virt != 0;
    wire [31:0] w_virt_irq      = (w_key_req) ? w_cons_irq : (w_isdisk) ? w_disk_irq : w_cons_irq;
    wire        w_virt_irq_oe   = w_cons_irq_oe | w_disk_irq_oe | w_key_req;

    m_RVuc mc(CLK, (r_mc_mode!=0), w_dram_busy, w_mc_addr, w_mc_arg, w_mc_wdata,
                w_mc_we, w_mc_ctrl, w_mc_aces);


    m_console   console(CLK, 1'b1, w_cons_we, w_cons_addr, w_mem_wdata, plic_pending_irq, w_cons_data,
                        w_cons_irq, w_cons_irq_oe, r_mc_mode, w_cons_req, w_cons_qnum, w_cons_qsel, w_key_req);
    
    m_disk      disk(CLK, 1'b1, w_disk_we, w_disk_addr, w_mem_wdata, plic_pending_irq, w_disk_data,
                        w_disk_irq, w_disk_irq_oe, r_mc_mode, w_disk_req, w_disk_qnum, w_disk_qsel);


    /***********************************           PLIC         ***********************************/
    wire [31:0] w_plic_pending_irq_nxt  =   w_virt_irq_oe ? w_virt_irq : plic_pending_irq;
    wire [31:0] w_plic_mask             =   w_plic_pending_irq_nxt & ~plic_served_irq;
    wire [31:0] w_plic_served_irq_nxt   =   (w_virt_irq_oe) ? plic_served_irq :
                                            (w_isread) ? plic_served_irq | w_plic_mask :
                                            plic_served_irq & ~(1 << (w_data_wdata-1));

    wire w_plic_aces = (w_dev == `PLIC_BASE_TADDR && !w_tlb_busy &&
            ((w_isread && w_plic_mask != 0) || (w_iswrite && w_offset == `PLIC_HART_BASE+4)));

    reg  [31:0] r_wmip = 0;
    reg         r_plic_we = 0;

    reg  [31:0] r_plic_pending_irq_t    = 0;
    reg  [31:0] r_plic_served_irq_t     = 0;

    reg         r_virt_irq_oe_t = 0;
    reg         r_plic_aces_t   = 0;

    wire [31:0] w_plic_mask_nxt = r_plic_pending_irq_t & ~r_plic_served_irq_t;

    always@(posedge CLK) begin
        if(!w_tlb_busy) begin
            //r_plic_we   <= (w_virt_irq_oe || w_plic_aces);
            r_virt_irq_oe_t         <= w_virt_irq_oe;
            r_plic_aces_t           <= w_plic_aces;
            r_plic_pending_irq_t    <= w_plic_pending_irq_nxt;
            r_plic_served_irq_t     <= w_plic_served_irq_nxt;
        end
    end

    assign w_plic_we    = (r_virt_irq_oe_t || r_plic_aces_t);//r_plic_we;
    assign w_wmip       = (w_plic_mask_nxt) ? w_mip | (`MIP_MEIP | `MIP_SEIP) :
                            w_mip & ~(`MIP_MEIP | `MIP_SEIP);

//    assign w_plic_we = (w_virt_irq_oe || w_plic_aces);
//    assign w_wmip    = (w_plic_mask_nxt) ? w_mip | (`MIP_MEIP | `MIP_SEIP) :
                        //w_mip & ~(`MIP_MEIP | `MIP_SEIP);

    /***********************************          CLINT         ***********************************/
    assign w_wmtimecmp  = (r_dev == `CLINT_BASE_TADDR && w_offset==28'h4000 && w_data_we != 0) ?
                                {w_mtimecmp[63:32], w_data_wdata} :
                          (r_dev == `CLINT_BASE_TADDR && w_offset==28'h4004 && w_data_we != 0) ?
                                {w_data_wdata, w_mtimecmp[31:0]} : 0;
    assign w_clint_we   = (r_dev == `CLINT_BASE_TADDR && w_data_we != 0);

    /***********************************           BUSY         ***********************************/
    assign w_tlb_busy = 
                    !(w_use_tlb)                            ? 0 :
                    (r_pw_state == 7)                       ? 0 : 1;
/*                    (r_pw_state != 0)                       ? 1 :
                    ((w_iscode && w_tlb_inst_r_oe) ||
                    (w_isread && w_tlb_data_r_oe)  ||
                    (w_iswrite && w_tlb_data_w_oe))         ? 0 : 1;*/
    
    /*wire w_mc_busy =    (r_mc_done)                                                 ? 0 :
                        (r_mc_mode != 0 || w_cons_req || w_key_req || w_disk_req)   ? 1 : 0;*/
    wire w_mc_busy =    (r_mc_mode != 0) ? 1 : 0;


    wire w_tx_ready;
    assign w_proc_busy = w_tlb_busy || w_mc_busy || w_dram_busy || !w_tx_ready;
    /**********************************************************************************************/
    // PLIC, CLINT ACCESS
    reg         r_uart_we = 0;
    reg   [7:0] r_uart_data = 0;

    always@(posedge CLK) begin
        r_dev   <= w_dev;
        r_virt  <= w_virt;

        /*********************************         TOHOST         *********************************/
        // OUTPUT CHAR
        if(r_tohost[31:16]==`CMD_PRINT_CHAR) begin
            r_uart_we   <= 1;
            r_uart_data <= r_tohost[7:0];
        end else begin 
            r_uart_we   <= 0;
            r_uart_data <= 0;
        end
        // Finish Simulation
        if(r_tohost[31:16]==`CMD_POWER_OFF) begin
            if(r_mc_mode==0) r_finish = 1;
            else begin
                r_tohost <= 0;
            end
        end
        else begin
            r_tohost <= (w_mem_paddr==`TOHOST_ADDR && w_mem_we) ? w_mem_wdata   :
                        (r_tohost[31:16]==`CMD_PRINT_CHAR)      ? 0             : r_tohost;
        end

        /**********************************         PLIC         **********************************/
        if(w_plic_aces) begin
            r_plic_odata    <= (w_plic_mask!=0) ? w_plic_mask : 0;
            plic_served_irq <= w_plic_served_irq_nxt;
        end

        if(w_virt_irq_oe) begin
            plic_pending_irq    <= w_virt_irq;
        end

        /*********************************          CLINT         *********************************/
        r_clint_odata <=    (w_offset==28'hbff8) ? w_mtime[31:0] :
                            (w_offset==28'hbffc) ? w_mtime[63:32] :
                            (w_offset==28'h4000) ? w_mtimecmp[31:0] :
                            (w_offset==28'h4004) ? w_mtimecmp[63:32] : 0;
    end
    /**********************************************************************************************/

    wire w_cons_txd;
    UartTx UartTx0(CLK, RST_X, r_uart_data, r_uart_we, w_cons_txd, w_tx_ready);

    assign w_uart_data = r_uart_data;
    assign w_uart_we   = r_uart_we;

    (* mark_debug *) wire [31:0]  w_pl_init_addr;
    (* mark_debug *) wire [31:0]  w_pl_init_data;
    (* mark_debug *) wire         w_pl_init_we;
    (* mark_debug *) wire         w_pl_init_done;
    PLOADER ploader(CLK, RST_X, w_rxd, w_pl_init_addr, w_pl_init_data, w_pl_init_we,
                    w_pl_init_done, w_key_we, w_key_data);

    /**********************************************************************************************/

    reg  [31:0]  r_checksum = 0;
    always@(posedge CLK) begin
        r_checksum <= (!RST_X)                      ? 0                             :
                      (!w_init_done & w_pl_init_we) ? r_checksum + w_pl_init_data   :
                      r_checksum;
    end

    assign w_checksum = r_checksum;

    /**********************************************************************************************/

    wire w_debug_txd;
    wire w_rec_done;
    m_debug_key debug_KEY(CLK, RST_X, w_debug_btnd, w_debug_txd, w_key_we, w_key_data, w_mtime[31:0], w_rec_done);

    assign w_txd = (w_rec_done) ? w_debug_txd : w_cons_txd;

/**************************************************************************************************/
    reg          r_bbl_done   = 0;
    reg          r_disk_done  = 0;
    reg          r_dtree_done = 0;
    reg  [31:0]  r_initaddr  = 0;
    reg  [31:0]  r_initaddr2 = (64*1024*1024); /* initial addres for Disk Drive */
    reg  [31:0]  r_initaddr3 = (16*1024*1024); /* initial address of Device Tree */

    // Zero init
    wire w_zero_we;
    reg  r_zero_we;
    reg  r_zero_done        = 0;
    reg  [31:0]  r_zeroaddr = 0;

`ifdef SIM_MODE
    reg  [2:0] r_init_state = 5;
`else
    reg  [2:0] r_init_state = 0;
    always@(posedge CLK) begin
        r_init_state <= (!RST_X) ? 0 :
                      (r_init_state == 0)              ? 1 :
                      (r_init_state == 1 & r_zero_done)  ? 2 :
                      (r_init_state == 2 & r_bbl_done)   ? 3 :
                      (r_init_state == 3 & r_dtree_done) ? 4 :   
                      (r_init_state == 4 & r_disk_done)  ? 5 :
                      r_init_state;
    end
`endif

//    assign w_init_start = (r_initaddr != 0);

    assign w_init_done = (r_init_state == 5);
        
    always@(posedge CLK) begin
        if(w_pl_init_we & (r_init_state == 2))      r_initaddr      <= r_initaddr + 4;
        if(r_initaddr  >= (9*1024*1024))            r_bbl_done      <= 1;
        if(w_pl_init_we & (r_init_state == 3))      r_initaddr3     <= r_initaddr3 + 4;
        if(r_initaddr3 >= (16*1024*1024 + 4*1024))  r_dtree_done    <= 1;
        if(w_pl_init_we & (r_init_state == 4))      r_initaddr2     <= r_initaddr2 + 4;
        if(r_initaddr2 >= ((64+16)*1024*1024))      r_disk_done     <= 1;
    end
    
    // Zero init
    wire calib_done;
    always@(posedge CLK) begin
`ifndef ARTYA7
        if(!w_dram_busy & !r_zero_done) r_zero_we <= 1;
`else
        if(!w_dram_busy & !r_zero_done & calib_done) r_zero_we <= 1;
`endif
        if(r_zero_we) begin
            r_zero_we    <= 0;
            r_zeroaddr <= r_zeroaddr + 4;
        end
        if(r_zeroaddr >= `MEM_SIZE) r_zero_done <= 1;
    end

`ifdef SIM_MODE
    assign w_zero_we = 0;
`else
    assign w_zero_we = r_zero_we;
`endif
    /**********************************************************************************************/
    wire [31:0] w_dram_addr_t   = ((w_dram_addr[31:28]==9) ?
                                    (w_dram_addr & 32'h3ffffff) + `BBL_SIZE :
                                    w_dram_addr & 32'h3ffffff);
    wire [31:0]  w_dram_addr_t2 =
                    (r_init_state == 1) ? r_zeroaddr     : 
                    (r_init_state == 2) ? r_initaddr     :
                    (r_init_state == 3) ? r_initaddr3    : 
                    (r_init_state == 4) ? r_initaddr2    : w_dram_addr_t;
    
    (* mark_debug *) wire [31:0]  w_dram_wdata_t   =   (r_init_state == 1) ? 32'b0 :
                                    (r_init_state == 5) ? w_dram_wdata : w_pl_init_data;
    wire         w_dram_we_t      =   (w_pte_we || w_dram_we || w_imag_we) && !w_dram_busy;
    wire [2:0]   w_dram_ctrl_t  = (!w_init_done) ? `FUNCT3_SW____ : w_dram_ctrl;
/**************************************************************************************************/

`ifdef SIM_MODE
    m_dram_sim#(`MEM_SIZE) idbmem(CLK, w_dram_addr_t2, w_dram_odata, w_dram_we_t, w_dram_le,
                                    w_dram_wdata_t, w_dram_ctrl_t, w_dram_busy, w_mtime[31:0]);
`else

    DRAM_conRV#(.APP_ADDR_WIDTH(APP_ADDR_WIDTH),
		.APP_CMD_WIDTH(APP_CMD_WIDTH),
		.APP_DATA_WIDTH(APP_DATA_WIDTH),
		.APP_MASK_WIDTH(APP_MASK_WIDTH))
    dram_con (
              // user interface ports
              .i_rd_en(w_dram_le),
              .i_wr_en(w_zero_we || w_pl_init_we || w_dram_we_t),
              .i_addr(w_dram_addr_t2),
              .i_data(w_dram_wdata_t),
              .o_data(w_dram_odata),
              .o_busy(w_dram_busy),
              .i_ctrl(w_dram_ctrl_t),

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

              .core_clk(core_clk),
              .core_rst_x(core_rst_x),
              // other
              .o_init_calib_complete(calib_done)
              );

`endif // !`ifdef SIM_MODE


    assign w_led = (w_proc_busy << 12) | (r_mc_mode << 8)
                    | ({w_pl_init_done, r_disk_done, r_bbl_done, r_zero_done} << 4) | r_init_state;
    
endmodule
/**************************************************************************************************/
/*** Simple Direct Mapped Cache for TLB                                                         ***/
/**************************************************************************************************/
module m_tlb#(parameter ADDR_WIDTH = 20, D_WIDTH = 20, ENTRY = 4)
            (CLK, RST_X, w_flush, w_we, w_waddr, w_raddr, w_idata, w_odata, w_oe);
    input  wire                     CLK, RST_X;
    input  wire                     w_flush, w_we;
    input  wire [ADDR_WIDTH-1:0]    w_waddr, w_raddr;
    input  wire    [D_WIDTH-1:0]    w_idata;
    output wire    [D_WIDTH-1:0]    w_odata;
    output wire                     w_oe;             //output enable

    reg                               [ENTRY-1:0]   r_valid = 0;
    reg  [(ADDR_WIDTH-$clog2(ENTRY)+D_WIDTH)-1:0]   mem [0:ENTRY-1];
    integer i;
    initial for(i=0; i<ENTRY; i=i+1) mem[i] = 0;

    // READ
    wire              [$clog2(ENTRY)-1:0]   w_ridx;
    wire [(ADDR_WIDTH-$clog2(ENTRY))-1:0]   w_rtag;
    assign {w_rtag, w_ridx} = w_raddr;

    wire w_tagmatch = (mem[w_ridx][(ADDR_WIDTH-$clog2(ENTRY)+D_WIDTH)-1:D_WIDTH] == w_rtag);

    assign w_odata  = mem[w_ridx][D_WIDTH-1:0];
    assign w_oe     = (w_tagmatch && r_valid[w_ridx]);

    // WRITE
    wire              [$clog2(ENTRY)-1:0]   w_widx;
    wire [(ADDR_WIDTH-$clog2(ENTRY))-1:0]   w_wtag;
    assign {w_wtag, w_widx} = w_waddr;

    always  @(posedge  CLK)  begin
        // FLUSH
        if (!RST_X || w_flush) begin
            r_valid <= 0;
        end
        if (w_we) begin
            mem[w_widx] <= {w_wtag, w_idata};
            r_valid[w_widx] <= 1;
        end
    end
endmodule // m_tlb

/**************************************************************************************************/
