create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clkgen1/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {m_main_i/c/dram_con/i_addr[0]} {m_main_i/c/dram_con/i_addr[1]} {m_main_i/c/dram_con/i_addr[2]} {m_main_i/c/dram_con/i_addr[3]} {m_main_i/c/dram_con/i_addr[4]} {m_main_i/c/dram_con/i_addr[5]} {m_main_i/c/dram_con/i_addr[6]} {m_main_i/c/dram_con/i_addr[7]} {m_main_i/c/dram_con/i_addr[8]} {m_main_i/c/dram_con/i_addr[9]} {m_main_i/c/dram_con/i_addr[10]} {m_main_i/c/dram_con/i_addr[11]} {m_main_i/c/dram_con/i_addr[12]} {m_main_i/c/dram_con/i_addr[13]} {m_main_i/c/dram_con/i_addr[14]} {m_main_i/c/dram_con/i_addr[15]} {m_main_i/c/dram_con/i_addr[16]} {m_main_i/c/dram_con/i_addr[17]} {m_main_i/c/dram_con/i_addr[18]} {m_main_i/c/dram_con/i_addr[19]} {m_main_i/c/dram_con/i_addr[20]} {m_main_i/c/dram_con/i_addr[21]} {m_main_i/c/dram_con/i_addr[22]} {m_main_i/c/dram_con/i_addr[23]} {m_main_i/c/dram_con/i_addr[24]} {m_main_i/c/dram_con/i_addr[25]} {m_main_i/c/dram_con/i_addr[26]} {m_main_i/c/dram_con/i_addr[27]} {m_main_i/c/dram_con/i_addr[28]} {m_main_i/c/dram_con/i_addr[29]} {m_main_i/c/dram_con/i_addr[30]} {m_main_i/c/dram_con/i_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {m_main_i/c/ploader/KEY_DATA[0]} {m_main_i/c/ploader/KEY_DATA[1]} {m_main_i/c/ploader/KEY_DATA[2]} {m_main_i/c/ploader/KEY_DATA[3]} {m_main_i/c/ploader/KEY_DATA[4]} {m_main_i/c/ploader/KEY_DATA[5]} {m_main_i/c/ploader/KEY_DATA[6]} {m_main_i/c/ploader/KEY_DATA[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {m_main_i/c/ploader/SER_DATA[0]} {m_main_i/c/ploader/SER_DATA[1]} {m_main_i/c/ploader/SER_DATA[2]} {m_main_i/c/ploader/SER_DATA[3]} {m_main_i/c/ploader/SER_DATA[4]} {m_main_i/c/ploader/SER_DATA[5]} {m_main_i/c/ploader/SER_DATA[6]} {m_main_i/c/ploader/SER_DATA[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {m_main_i/c/ploader/ADDR[0]} {m_main_i/c/ploader/ADDR[1]} {m_main_i/c/ploader/ADDR[2]} {m_main_i/c/ploader/ADDR[3]} {m_main_i/c/ploader/ADDR[4]} {m_main_i/c/ploader/ADDR[5]} {m_main_i/c/ploader/ADDR[6]} {m_main_i/c/ploader/ADDR[7]} {m_main_i/c/ploader/ADDR[8]} {m_main_i/c/ploader/ADDR[9]} {m_main_i/c/ploader/ADDR[10]} {m_main_i/c/ploader/ADDR[11]} {m_main_i/c/ploader/ADDR[12]} {m_main_i/c/ploader/ADDR[13]} {m_main_i/c/ploader/ADDR[14]} {m_main_i/c/ploader/ADDR[15]} {m_main_i/c/ploader/ADDR[16]} {m_main_i/c/ploader/ADDR[17]} {m_main_i/c/ploader/ADDR[18]} {m_main_i/c/ploader/ADDR[19]} {m_main_i/c/ploader/ADDR[20]} {m_main_i/c/ploader/ADDR[21]} {m_main_i/c/ploader/ADDR[22]} {m_main_i/c/ploader/ADDR[23]} {m_main_i/c/ploader/ADDR[24]} {m_main_i/c/ploader/ADDR[25]} {m_main_i/c/ploader/ADDR[26]} {m_main_i/c/ploader/ADDR[27]} {m_main_i/c/ploader/ADDR[28]} {m_main_i/c/ploader/ADDR[29]} {m_main_i/c/ploader/ADDR[30]} {m_main_i/c/ploader/ADDR[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {m_main_i/c/ploader/DATA[0]} {m_main_i/c/ploader/DATA[1]} {m_main_i/c/ploader/DATA[2]} {m_main_i/c/ploader/DATA[3]} {m_main_i/c/ploader/DATA[4]} {m_main_i/c/ploader/DATA[5]} {m_main_i/c/ploader/DATA[6]} {m_main_i/c/ploader/DATA[7]} {m_main_i/c/ploader/DATA[8]} {m_main_i/c/ploader/DATA[9]} {m_main_i/c/ploader/DATA[10]} {m_main_i/c/ploader/DATA[11]} {m_main_i/c/ploader/DATA[12]} {m_main_i/c/ploader/DATA[13]} {m_main_i/c/ploader/DATA[14]} {m_main_i/c/ploader/DATA[15]} {m_main_i/c/ploader/DATA[16]} {m_main_i/c/ploader/DATA[17]} {m_main_i/c/ploader/DATA[18]} {m_main_i/c/ploader/DATA[19]} {m_main_i/c/ploader/DATA[20]} {m_main_i/c/ploader/DATA[21]} {m_main_i/c/ploader/DATA[22]} {m_main_i/c/ploader/DATA[23]} {m_main_i/c/ploader/DATA[24]} {m_main_i/c/ploader/DATA[25]} {m_main_i/c/ploader/DATA[26]} {m_main_i/c/ploader/DATA[27]} {m_main_i/c/ploader/DATA[28]} {m_main_i/c/ploader/DATA[29]} {m_main_i/c/ploader/DATA[30]} {m_main_i/c/ploader/DATA[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 30 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[2]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[3]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[4]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[5]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[6]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[7]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[8]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[9]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[10]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[11]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[12]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[13]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[14]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[15]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[16]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[17]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[18]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[19]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[20]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[21]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[22]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[23]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[24]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[25]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[26]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[27]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[28]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[29]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[30]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {m_main_i/c/w_pl_init_data[0]} {m_main_i/c/w_pl_init_data[1]} {m_main_i/c/w_pl_init_data[2]} {m_main_i/c/w_pl_init_data[3]} {m_main_i/c/w_pl_init_data[4]} {m_main_i/c/w_pl_init_data[5]} {m_main_i/c/w_pl_init_data[6]} {m_main_i/c/w_pl_init_data[7]} {m_main_i/c/w_pl_init_data[8]} {m_main_i/c/w_pl_init_data[9]} {m_main_i/c/w_pl_init_data[10]} {m_main_i/c/w_pl_init_data[11]} {m_main_i/c/w_pl_init_data[12]} {m_main_i/c/w_pl_init_data[13]} {m_main_i/c/w_pl_init_data[14]} {m_main_i/c/w_pl_init_data[15]} {m_main_i/c/w_pl_init_data[16]} {m_main_i/c/w_pl_init_data[17]} {m_main_i/c/w_pl_init_data[18]} {m_main_i/c/w_pl_init_data[19]} {m_main_i/c/w_pl_init_data[20]} {m_main_i/c/w_pl_init_data[21]} {m_main_i/c/w_pl_init_data[22]} {m_main_i/c/w_pl_init_data[23]} {m_main_i/c/w_pl_init_data[24]} {m_main_i/c/w_pl_init_data[25]} {m_main_i/c/w_pl_init_data[26]} {m_main_i/c/w_pl_init_data[27]} {m_main_i/c/w_pl_init_data[28]} {m_main_i/c/w_pl_init_data[29]} {m_main_i/c/w_pl_init_data[30]} {m_main_i/c/w_pl_init_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {m_main_i/c/w_dram_wdata_t[0]} {m_main_i/c/w_dram_wdata_t[1]} {m_main_i/c/w_dram_wdata_t[2]} {m_main_i/c/w_dram_wdata_t[3]} {m_main_i/c/w_dram_wdata_t[4]} {m_main_i/c/w_dram_wdata_t[5]} {m_main_i/c/w_dram_wdata_t[6]} {m_main_i/c/w_dram_wdata_t[7]} {m_main_i/c/w_dram_wdata_t[8]} {m_main_i/c/w_dram_wdata_t[9]} {m_main_i/c/w_dram_wdata_t[10]} {m_main_i/c/w_dram_wdata_t[11]} {m_main_i/c/w_dram_wdata_t[12]} {m_main_i/c/w_dram_wdata_t[13]} {m_main_i/c/w_dram_wdata_t[14]} {m_main_i/c/w_dram_wdata_t[15]} {m_main_i/c/w_dram_wdata_t[16]} {m_main_i/c/w_dram_wdata_t[17]} {m_main_i/c/w_dram_wdata_t[18]} {m_main_i/c/w_dram_wdata_t[19]} {m_main_i/c/w_dram_wdata_t[20]} {m_main_i/c/w_dram_wdata_t[21]} {m_main_i/c/w_dram_wdata_t[22]} {m_main_i/c/w_dram_wdata_t[23]} {m_main_i/c/w_dram_wdata_t[24]} {m_main_i/c/w_dram_wdata_t[25]} {m_main_i/c/w_dram_wdata_t[26]} {m_main_i/c/w_dram_wdata_t[27]} {m_main_i/c/w_dram_wdata_t[28]} {m_main_i/c/w_dram_wdata_t[29]} {m_main_i/c/w_dram_wdata_t[30]} {m_main_i/c/w_dram_wdata_t[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {m_main_i/c/dram_con/i_data[0]} {m_main_i/c/dram_con/i_data[1]} {m_main_i/c/dram_con/i_data[2]} {m_main_i/c/dram_con/i_data[3]} {m_main_i/c/dram_con/i_data[4]} {m_main_i/c/dram_con/i_data[5]} {m_main_i/c/dram_con/i_data[6]} {m_main_i/c/dram_con/i_data[7]} {m_main_i/c/dram_con/i_data[8]} {m_main_i/c/dram_con/i_data[9]} {m_main_i/c/dram_con/i_data[10]} {m_main_i/c/dram_con/i_data[11]} {m_main_i/c/dram_con/i_data[12]} {m_main_i/c/dram_con/i_data[13]} {m_main_i/c/dram_con/i_data[14]} {m_main_i/c/dram_con/i_data[15]} {m_main_i/c/dram_con/i_data[16]} {m_main_i/c/dram_con/i_data[17]} {m_main_i/c/dram_con/i_data[18]} {m_main_i/c/dram_con/i_data[19]} {m_main_i/c/dram_con/i_data[20]} {m_main_i/c/dram_con/i_data[21]} {m_main_i/c/dram_con/i_data[22]} {m_main_i/c/dram_con/i_data[23]} {m_main_i/c/dram_con/i_data[24]} {m_main_i/c/dram_con/i_data[25]} {m_main_i/c/dram_con/i_data[26]} {m_main_i/c/dram_con/i_data[27]} {m_main_i/c/dram_con/i_data[28]} {m_main_i/c/dram_con/i_data[29]} {m_main_i/c/dram_con/i_data[30]} {m_main_i/c/dram_con/i_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 69 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[0]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[1]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[2]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[3]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[4]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[5]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[6]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[7]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[8]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[9]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[10]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[11]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[12]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[13]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[14]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[15]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[16]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[17]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[18]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[19]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[20]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[21]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[22]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[23]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[24]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[25]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[26]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[27]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[28]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[29]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[30]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[31]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[32]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[33]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[34]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[35]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[36]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[37]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[38]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[39]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[40]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[41]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[42]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[43]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[44]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[45]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[46]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[47]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[48]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[49]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[50]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[51]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[52]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[53]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[54]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[55]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[56]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[57]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[58]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[59]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[60]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[61]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[62]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[63]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[64]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[65]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[66]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[67]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/din_afifo1[68]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[0]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[1]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[2]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[3]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[4]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[5]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[6]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[7]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[8]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[9]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[10]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[11]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[12]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[13]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[14]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[15]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[16]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[17]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[18]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[19]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[20]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[21]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[22]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[23]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[24]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[25]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[26]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[27]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[28]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[29]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[30]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 32 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {m_main_i/c/w_pl_init_addr[0]} {m_main_i/c/w_pl_init_addr[1]} {m_main_i/c/w_pl_init_addr[2]} {m_main_i/c/w_pl_init_addr[3]} {m_main_i/c/w_pl_init_addr[4]} {m_main_i/c/w_pl_init_addr[5]} {m_main_i/c/w_pl_init_addr[6]} {m_main_i/c/w_pl_init_addr[7]} {m_main_i/c/w_pl_init_addr[8]} {m_main_i/c/w_pl_init_addr[9]} {m_main_i/c/w_pl_init_addr[10]} {m_main_i/c/w_pl_init_addr[11]} {m_main_i/c/w_pl_init_addr[12]} {m_main_i/c/w_pl_init_addr[13]} {m_main_i/c/w_pl_init_addr[14]} {m_main_i/c/w_pl_init_addr[15]} {m_main_i/c/w_pl_init_addr[16]} {m_main_i/c/w_pl_init_addr[17]} {m_main_i/c/w_pl_init_addr[18]} {m_main_i/c/w_pl_init_addr[19]} {m_main_i/c/w_pl_init_addr[20]} {m_main_i/c/w_pl_init_addr[21]} {m_main_i/c/w_pl_init_addr[22]} {m_main_i/c/w_pl_init_addr[23]} {m_main_i/c/w_pl_init_addr[24]} {m_main_i/c/w_pl_init_addr[25]} {m_main_i/c/w_pl_init_addr[26]} {m_main_i/c/w_pl_init_addr[27]} {m_main_i/c/w_pl_init_addr[28]} {m_main_i/c/w_pl_init_addr[29]} {m_main_i/c/w_pl_init_addr[30]} {m_main_i/c/w_pl_init_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 32 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {m_main_i/c/dram_con/dram/i_data[0]} {m_main_i/c/dram_con/dram/i_data[1]} {m_main_i/c/dram_con/dram/i_data[2]} {m_main_i/c/dram_con/dram/i_data[3]} {m_main_i/c/dram_con/dram/i_data[4]} {m_main_i/c/dram_con/dram/i_data[5]} {m_main_i/c/dram_con/dram/i_data[6]} {m_main_i/c/dram_con/dram/i_data[7]} {m_main_i/c/dram_con/dram/i_data[8]} {m_main_i/c/dram_con/dram/i_data[9]} {m_main_i/c/dram_con/dram/i_data[10]} {m_main_i/c/dram_con/dram/i_data[11]} {m_main_i/c/dram_con/dram/i_data[12]} {m_main_i/c/dram_con/dram/i_data[13]} {m_main_i/c/dram_con/dram/i_data[14]} {m_main_i/c/dram_con/dram/i_data[15]} {m_main_i/c/dram_con/dram/i_data[16]} {m_main_i/c/dram_con/dram/i_data[17]} {m_main_i/c/dram_con/dram/i_data[18]} {m_main_i/c/dram_con/dram/i_data[19]} {m_main_i/c/dram_con/dram/i_data[20]} {m_main_i/c/dram_con/dram/i_data[21]} {m_main_i/c/dram_con/dram/i_data[22]} {m_main_i/c/dram_con/dram/i_data[23]} {m_main_i/c/dram_con/dram/i_data[24]} {m_main_i/c/dram_con/dram/i_data[25]} {m_main_i/c/dram_con/dram/i_data[26]} {m_main_i/c/dram_con/dram/i_data[27]} {m_main_i/c/dram_con/dram/i_data[28]} {m_main_i/c/dram_con/dram/i_data[29]} {m_main_i/c/dram_con/dram/i_data[30]} {m_main_i/c/dram_con/dram/i_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {m_main_i/c/dram_con/dram/i_addr[0]} {m_main_i/c/dram_con/dram/i_addr[1]} {m_main_i/c/dram_con/dram/i_addr[2]} {m_main_i/c/dram_con/dram/i_addr[3]} {m_main_i/c/dram_con/dram/i_addr[4]} {m_main_i/c/dram_con/dram/i_addr[5]} {m_main_i/c/dram_con/dram/i_addr[6]} {m_main_i/c/dram_con/dram/i_addr[7]} {m_main_i/c/dram_con/dram/i_addr[8]} {m_main_i/c/dram_con/dram/i_addr[9]} {m_main_i/c/dram_con/dram/i_addr[10]} {m_main_i/c/dram_con/dram/i_addr[11]} {m_main_i/c/dram_con/dram/i_addr[12]} {m_main_i/c/dram_con/dram/i_addr[13]} {m_main_i/c/dram_con/dram/i_addr[14]} {m_main_i/c/dram_con/dram/i_addr[15]} {m_main_i/c/dram_con/dram/i_addr[16]} {m_main_i/c/dram_con/dram/i_addr[17]} {m_main_i/c/dram_con/dram/i_addr[18]} {m_main_i/c/dram_con/dram/i_addr[19]} {m_main_i/c/dram_con/dram/i_addr[20]} {m_main_i/c/dram_con/dram/i_addr[21]} {m_main_i/c/dram_con/dram/i_addr[22]} {m_main_i/c/dram_con/dram/i_addr[23]} {m_main_i/c/dram_con/dram/i_addr[24]} {m_main_i/c/dram_con/dram/i_addr[25]} {m_main_i/c/dram_con/dram/i_addr[26]} {m_main_i/c/dram_con/dram/i_addr[27]} {m_main_i/c/dram_con/dram/i_addr[28]} {m_main_i/c/dram_con/dram/i_addr[29]} {m_main_i/c/dram_con/dram/i_addr[30]} {m_main_i/c/dram_con/dram/i_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list m_main_i/c/ploader/DONE]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_rd_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list m_main_i/c/dram_con/i_rd_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list m_main_i/c/dram_con/dram/i_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list m_main_i/c/dram_con/dram/dram/dram_con_without_cache/i_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list m_main_i/c/dram_con/i_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list m_main_i/c/ploader/KEY_WE]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list m_main_i/c/ploader/SER_EN]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list m_main_i/c/w_pl_init_done]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list m_main_i/c/w_pl_init_we]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list m_main_i/c/ploader/WE]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list ddr4_0_i/inst/u_ddr4_infrastructure/div_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 16 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {s_axi_wstrb[0]} {s_axi_wstrb[1]} {s_axi_wstrb[2]} {s_axi_wstrb[3]} {s_axi_wstrb[4]} {s_axi_wstrb[5]} {s_axi_wstrb[6]} {s_axi_wstrb[7]} {s_axi_wstrb[8]} {s_axi_wstrb[9]} {s_axi_wstrb[10]} {s_axi_wstrb[11]} {s_axi_wstrb[12]} {s_axi_wstrb[13]} {s_axi_wstrb[14]} {s_axi_wstrb[15]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 2 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list {s_axi_arburst[0]} {s_axi_arburst[1]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 4 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list {s_axi_rid[0]} {s_axi_rid[1]} {s_axi_rid[2]} {s_axi_rid[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
set_property port_width 128 [get_debug_ports u_ila_1/probe3]
connect_debug_port u_ila_1/probe3 [get_nets [list {s_axi_wdata[0]} {s_axi_wdata[1]} {s_axi_wdata[2]} {s_axi_wdata[3]} {s_axi_wdata[4]} {s_axi_wdata[5]} {s_axi_wdata[6]} {s_axi_wdata[7]} {s_axi_wdata[8]} {s_axi_wdata[9]} {s_axi_wdata[10]} {s_axi_wdata[11]} {s_axi_wdata[12]} {s_axi_wdata[13]} {s_axi_wdata[14]} {s_axi_wdata[15]} {s_axi_wdata[16]} {s_axi_wdata[17]} {s_axi_wdata[18]} {s_axi_wdata[19]} {s_axi_wdata[20]} {s_axi_wdata[21]} {s_axi_wdata[22]} {s_axi_wdata[23]} {s_axi_wdata[24]} {s_axi_wdata[25]} {s_axi_wdata[26]} {s_axi_wdata[27]} {s_axi_wdata[28]} {s_axi_wdata[29]} {s_axi_wdata[30]} {s_axi_wdata[31]} {s_axi_wdata[32]} {s_axi_wdata[33]} {s_axi_wdata[34]} {s_axi_wdata[35]} {s_axi_wdata[36]} {s_axi_wdata[37]} {s_axi_wdata[38]} {s_axi_wdata[39]} {s_axi_wdata[40]} {s_axi_wdata[41]} {s_axi_wdata[42]} {s_axi_wdata[43]} {s_axi_wdata[44]} {s_axi_wdata[45]} {s_axi_wdata[46]} {s_axi_wdata[47]} {s_axi_wdata[48]} {s_axi_wdata[49]} {s_axi_wdata[50]} {s_axi_wdata[51]} {s_axi_wdata[52]} {s_axi_wdata[53]} {s_axi_wdata[54]} {s_axi_wdata[55]} {s_axi_wdata[56]} {s_axi_wdata[57]} {s_axi_wdata[58]} {s_axi_wdata[59]} {s_axi_wdata[60]} {s_axi_wdata[61]} {s_axi_wdata[62]} {s_axi_wdata[63]} {s_axi_wdata[64]} {s_axi_wdata[65]} {s_axi_wdata[66]} {s_axi_wdata[67]} {s_axi_wdata[68]} {s_axi_wdata[69]} {s_axi_wdata[70]} {s_axi_wdata[71]} {s_axi_wdata[72]} {s_axi_wdata[73]} {s_axi_wdata[74]} {s_axi_wdata[75]} {s_axi_wdata[76]} {s_axi_wdata[77]} {s_axi_wdata[78]} {s_axi_wdata[79]} {s_axi_wdata[80]} {s_axi_wdata[81]} {s_axi_wdata[82]} {s_axi_wdata[83]} {s_axi_wdata[84]} {s_axi_wdata[85]} {s_axi_wdata[86]} {s_axi_wdata[87]} {s_axi_wdata[88]} {s_axi_wdata[89]} {s_axi_wdata[90]} {s_axi_wdata[91]} {s_axi_wdata[92]} {s_axi_wdata[93]} {s_axi_wdata[94]} {s_axi_wdata[95]} {s_axi_wdata[96]} {s_axi_wdata[97]} {s_axi_wdata[98]} {s_axi_wdata[99]} {s_axi_wdata[100]} {s_axi_wdata[101]} {s_axi_wdata[102]} {s_axi_wdata[103]} {s_axi_wdata[104]} {s_axi_wdata[105]} {s_axi_wdata[106]} {s_axi_wdata[107]} {s_axi_wdata[108]} {s_axi_wdata[109]} {s_axi_wdata[110]} {s_axi_wdata[111]} {s_axi_wdata[112]} {s_axi_wdata[113]} {s_axi_wdata[114]} {s_axi_wdata[115]} {s_axi_wdata[116]} {s_axi_wdata[117]} {s_axi_wdata[118]} {s_axi_wdata[119]} {s_axi_wdata[120]} {s_axi_wdata[121]} {s_axi_wdata[122]} {s_axi_wdata[123]} {s_axi_wdata[124]} {s_axi_wdata[125]} {s_axi_wdata[126]} {s_axi_wdata[127]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
set_property port_width 2 [get_debug_ports u_ila_1/probe4]
connect_debug_port u_ila_1/probe4 [get_nets [list {s_axi_rresp[0]} {s_axi_rresp[1]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
set_property port_width 32 [get_debug_ports u_ila_1/probe5]
connect_debug_port u_ila_1/probe5 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[96]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[97]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[98]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[99]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[100]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[101]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[102]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[103]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[104]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[105]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[106]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[107]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[108]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[109]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[110]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[111]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[112]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[113]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[114]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[115]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[116]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[117]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[118]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[119]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[120]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[121]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[122]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[123]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[124]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[125]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[126]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[127]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe6]
set_property port_width 23 [get_debug_ports u_ila_1/probe6]
connect_debug_port u_ila_1/probe6 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[3]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[4]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[5]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[6]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[7]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[8]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[9]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[10]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[11]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[12]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[13]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[14]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[15]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[16]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[17]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[18]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[19]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[20]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[21]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[22]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[23]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[24]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[25]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe7]
set_property port_width 16 [get_debug_ports u_ila_1/probe7]
connect_debug_port u_ila_1/probe7 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[0]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[1]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[2]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[3]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[4]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[5]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[6]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[7]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[8]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[9]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[10]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[11]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[12]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[13]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[14]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[15]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe8]
set_property port_width 28 [get_debug_ports u_ila_1/probe8]
connect_debug_port u_ila_1/probe8 [get_nets [list {s_axi_araddr[0]} {s_axi_araddr[1]} {s_axi_araddr[2]} {s_axi_araddr[3]} {s_axi_araddr[4]} {s_axi_araddr[5]} {s_axi_araddr[6]} {s_axi_araddr[7]} {s_axi_araddr[8]} {s_axi_araddr[9]} {s_axi_araddr[10]} {s_axi_araddr[11]} {s_axi_araddr[12]} {s_axi_araddr[13]} {s_axi_araddr[14]} {s_axi_araddr[15]} {s_axi_araddr[16]} {s_axi_araddr[17]} {s_axi_araddr[18]} {s_axi_araddr[19]} {s_axi_araddr[20]} {s_axi_araddr[21]} {s_axi_araddr[22]} {s_axi_araddr[23]} {s_axi_araddr[24]} {s_axi_araddr[25]} {s_axi_araddr[26]} {s_axi_araddr[27]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe9]
set_property port_width 4 [get_debug_ports u_ila_1/probe9]
connect_debug_port u_ila_1/probe9 [get_nets [list {s_axi_arqos[0]} {s_axi_arqos[1]} {s_axi_arqos[2]} {s_axi_arqos[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe10]
set_property port_width 3 [get_debug_ports u_ila_1/probe10]
connect_debug_port u_ila_1/probe10 [get_nets [list {s_axi_arprot[0]} {s_axi_arprot[1]} {s_axi_arprot[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe11]
set_property port_width 4 [get_debug_ports u_ila_1/probe11]
connect_debug_port u_ila_1/probe11 [get_nets [list {s_axi_awcache[0]} {s_axi_awcache[1]} {s_axi_awcache[2]} {s_axi_awcache[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe12]
set_property port_width 2 [get_debug_ports u_ila_1/probe12]
connect_debug_port u_ila_1/probe12 [get_nets [list {s_axi_awburst[0]} {s_axi_awburst[1]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe13]
set_property port_width 28 [get_debug_ports u_ila_1/probe13]
connect_debug_port u_ila_1/probe13 [get_nets [list {s_axi_awaddr[0]} {s_axi_awaddr[1]} {s_axi_awaddr[2]} {s_axi_awaddr[3]} {s_axi_awaddr[4]} {s_axi_awaddr[5]} {s_axi_awaddr[6]} {s_axi_awaddr[7]} {s_axi_awaddr[8]} {s_axi_awaddr[9]} {s_axi_awaddr[10]} {s_axi_awaddr[11]} {s_axi_awaddr[12]} {s_axi_awaddr[13]} {s_axi_awaddr[14]} {s_axi_awaddr[15]} {s_axi_awaddr[16]} {s_axi_awaddr[17]} {s_axi_awaddr[18]} {s_axi_awaddr[19]} {s_axi_awaddr[20]} {s_axi_awaddr[21]} {s_axi_awaddr[22]} {s_axi_awaddr[23]} {s_axi_awaddr[24]} {s_axi_awaddr[25]} {s_axi_awaddr[26]} {s_axi_awaddr[27]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe14]
set_property port_width 3 [get_debug_ports u_ila_1/probe14]
connect_debug_port u_ila_1/probe14 [get_nets [list {s_axi_arsize[0]} {s_axi_arsize[1]} {s_axi_arsize[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe15]
set_property port_width 4 [get_debug_ports u_ila_1/probe15]
connect_debug_port u_ila_1/probe15 [get_nets [list {s_axi_bid[0]} {s_axi_bid[1]} {s_axi_bid[2]} {s_axi_bid[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe16]
set_property port_width 2 [get_debug_ports u_ila_1/probe16]
connect_debug_port u_ila_1/probe16 [get_nets [list {s_axi_bresp[0]} {s_axi_bresp[1]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe17]
set_property port_width 128 [get_debug_ports u_ila_1/probe17]
connect_debug_port u_ila_1/probe17 [get_nets [list {s_axi_rdata[0]} {s_axi_rdata[1]} {s_axi_rdata[2]} {s_axi_rdata[3]} {s_axi_rdata[4]} {s_axi_rdata[5]} {s_axi_rdata[6]} {s_axi_rdata[7]} {s_axi_rdata[8]} {s_axi_rdata[9]} {s_axi_rdata[10]} {s_axi_rdata[11]} {s_axi_rdata[12]} {s_axi_rdata[13]} {s_axi_rdata[14]} {s_axi_rdata[15]} {s_axi_rdata[16]} {s_axi_rdata[17]} {s_axi_rdata[18]} {s_axi_rdata[19]} {s_axi_rdata[20]} {s_axi_rdata[21]} {s_axi_rdata[22]} {s_axi_rdata[23]} {s_axi_rdata[24]} {s_axi_rdata[25]} {s_axi_rdata[26]} {s_axi_rdata[27]} {s_axi_rdata[28]} {s_axi_rdata[29]} {s_axi_rdata[30]} {s_axi_rdata[31]} {s_axi_rdata[32]} {s_axi_rdata[33]} {s_axi_rdata[34]} {s_axi_rdata[35]} {s_axi_rdata[36]} {s_axi_rdata[37]} {s_axi_rdata[38]} {s_axi_rdata[39]} {s_axi_rdata[40]} {s_axi_rdata[41]} {s_axi_rdata[42]} {s_axi_rdata[43]} {s_axi_rdata[44]} {s_axi_rdata[45]} {s_axi_rdata[46]} {s_axi_rdata[47]} {s_axi_rdata[48]} {s_axi_rdata[49]} {s_axi_rdata[50]} {s_axi_rdata[51]} {s_axi_rdata[52]} {s_axi_rdata[53]} {s_axi_rdata[54]} {s_axi_rdata[55]} {s_axi_rdata[56]} {s_axi_rdata[57]} {s_axi_rdata[58]} {s_axi_rdata[59]} {s_axi_rdata[60]} {s_axi_rdata[61]} {s_axi_rdata[62]} {s_axi_rdata[63]} {s_axi_rdata[64]} {s_axi_rdata[65]} {s_axi_rdata[66]} {s_axi_rdata[67]} {s_axi_rdata[68]} {s_axi_rdata[69]} {s_axi_rdata[70]} {s_axi_rdata[71]} {s_axi_rdata[72]} {s_axi_rdata[73]} {s_axi_rdata[74]} {s_axi_rdata[75]} {s_axi_rdata[76]} {s_axi_rdata[77]} {s_axi_rdata[78]} {s_axi_rdata[79]} {s_axi_rdata[80]} {s_axi_rdata[81]} {s_axi_rdata[82]} {s_axi_rdata[83]} {s_axi_rdata[84]} {s_axi_rdata[85]} {s_axi_rdata[86]} {s_axi_rdata[87]} {s_axi_rdata[88]} {s_axi_rdata[89]} {s_axi_rdata[90]} {s_axi_rdata[91]} {s_axi_rdata[92]} {s_axi_rdata[93]} {s_axi_rdata[94]} {s_axi_rdata[95]} {s_axi_rdata[96]} {s_axi_rdata[97]} {s_axi_rdata[98]} {s_axi_rdata[99]} {s_axi_rdata[100]} {s_axi_rdata[101]} {s_axi_rdata[102]} {s_axi_rdata[103]} {s_axi_rdata[104]} {s_axi_rdata[105]} {s_axi_rdata[106]} {s_axi_rdata[107]} {s_axi_rdata[108]} {s_axi_rdata[109]} {s_axi_rdata[110]} {s_axi_rdata[111]} {s_axi_rdata[112]} {s_axi_rdata[113]} {s_axi_rdata[114]} {s_axi_rdata[115]} {s_axi_rdata[116]} {s_axi_rdata[117]} {s_axi_rdata[118]} {s_axi_rdata[119]} {s_axi_rdata[120]} {s_axi_rdata[121]} {s_axi_rdata[122]} {s_axi_rdata[123]} {s_axi_rdata[124]} {s_axi_rdata[125]} {s_axi_rdata[126]} {s_axi_rdata[127]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe18]
set_property port_width 3 [get_debug_ports u_ila_1/probe18]
connect_debug_port u_ila_1/probe18 [get_nets [list {s_axi_awsize[0]} {s_axi_awsize[1]} {s_axi_awsize[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe19]
set_property port_width 32 [get_debug_ports u_ila_1/probe19]
connect_debug_port u_ila_1/probe19 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[0]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[1]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[2]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[3]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[4]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[5]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[6]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[7]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[8]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[9]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[10]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[11]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[12]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[13]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[14]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[15]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[16]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[17]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[18]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[19]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[20]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[21]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[22]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[23]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[24]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[25]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[26]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[27]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[28]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[29]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[30]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dout_afifo1_data[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe20]
set_property port_width 3 [get_debug_ports u_ila_1/probe20]
connect_debug_port u_ila_1/probe20 [get_nets [list {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/state[0]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/state[1]} {m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/state[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe21]
set_property port_width 3 [get_debug_ports u_ila_1/probe21]
connect_debug_port u_ila_1/probe21 [get_nets [list {s_axi_awprot[0]} {s_axi_awprot[1]} {s_axi_awprot[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe22]
set_property port_width 4 [get_debug_ports u_ila_1/probe22]
connect_debug_port u_ila_1/probe22 [get_nets [list {s_axi_awid[0]} {s_axi_awid[1]} {s_axi_awid[2]} {s_axi_awid[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe23]
set_property port_width 8 [get_debug_ports u_ila_1/probe23]
connect_debug_port u_ila_1/probe23 [get_nets [list {s_axi_awlen[0]} {s_axi_awlen[1]} {s_axi_awlen[2]} {s_axi_awlen[3]} {s_axi_awlen[4]} {s_axi_awlen[5]} {s_axi_awlen[6]} {s_axi_awlen[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe24]
set_property port_width 4 [get_debug_ports u_ila_1/probe24]
connect_debug_port u_ila_1/probe24 [get_nets [list {s_axi_awqos[0]} {s_axi_awqos[1]} {s_axi_awqos[2]} {s_axi_awqos[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe25]
set_property port_width 4 [get_debug_ports u_ila_1/probe25]
connect_debug_port u_ila_1/probe25 [get_nets [list {s_axi_arcache[0]} {s_axi_arcache[1]} {s_axi_arcache[2]} {s_axi_arcache[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe26]
set_property port_width 8 [get_debug_ports u_ila_1/probe26]
connect_debug_port u_ila_1/probe26 [get_nets [list {s_axi_arlen[0]} {s_axi_arlen[1]} {s_axi_arlen[2]} {s_axi_arlen[3]} {s_axi_arlen[4]} {s_axi_arlen[5]} {s_axi_arlen[6]} {s_axi_arlen[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe27]
set_property port_width 4 [get_debug_ports u_ila_1/probe27]
connect_debug_port u_ila_1/probe27 [get_nets [list {s_axi_arid[0]} {s_axi_arid[1]} {s_axi_arid[2]} {s_axi_arid[3]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe28]
set_property port_width 1 [get_debug_ports u_ila_1/probe28]
connect_debug_port u_ila_1/probe28 [get_nets [list m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_rd_en]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe29]
set_property port_width 1 [get_debug_ports u_ila_1/probe29]
connect_debug_port u_ila_1/probe29 [get_nets [list m_main_i/c/dram_con/dram/dram/dram_con_without_cache/dc/i_wr_en]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe30]
set_property port_width 1 [get_debug_ports u_ila_1/probe30]
connect_debug_port u_ila_1/probe30 [get_nets [list init_calib_complete]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe31]
set_property port_width 1 [get_debug_ports u_ila_1/probe31]
connect_debug_port u_ila_1/probe31 [get_nets [list s_axi_arlock]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe32]
set_property port_width 1 [get_debug_ports u_ila_1/probe32]
connect_debug_port u_ila_1/probe32 [get_nets [list s_axi_arready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe33]
set_property port_width 1 [get_debug_ports u_ila_1/probe33]
connect_debug_port u_ila_1/probe33 [get_nets [list s_axi_arvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe34]
set_property port_width 1 [get_debug_ports u_ila_1/probe34]
connect_debug_port u_ila_1/probe34 [get_nets [list s_axi_awlock]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe35]
set_property port_width 1 [get_debug_ports u_ila_1/probe35]
connect_debug_port u_ila_1/probe35 [get_nets [list s_axi_awready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe36]
set_property port_width 1 [get_debug_ports u_ila_1/probe36]
connect_debug_port u_ila_1/probe36 [get_nets [list s_axi_awvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe37]
set_property port_width 1 [get_debug_ports u_ila_1/probe37]
connect_debug_port u_ila_1/probe37 [get_nets [list s_axi_bready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe38]
set_property port_width 1 [get_debug_ports u_ila_1/probe38]
connect_debug_port u_ila_1/probe38 [get_nets [list s_axi_bvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe39]
set_property port_width 1 [get_debug_ports u_ila_1/probe39]
connect_debug_port u_ila_1/probe39 [get_nets [list s_axi_rlast]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe40]
set_property port_width 1 [get_debug_ports u_ila_1/probe40]
connect_debug_port u_ila_1/probe40 [get_nets [list s_axi_rready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe41]
set_property port_width 1 [get_debug_ports u_ila_1/probe41]
connect_debug_port u_ila_1/probe41 [get_nets [list s_axi_rvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe42]
set_property port_width 1 [get_debug_ports u_ila_1/probe42]
connect_debug_port u_ila_1/probe42 [get_nets [list s_axi_wlast]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe43]
set_property port_width 1 [get_debug_ports u_ila_1/probe43]
connect_debug_port u_ila_1/probe43 [get_nets [list s_axi_wready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe44]
set_property port_width 1 [get_debug_ports u_ila_1/probe44]
connect_debug_port u_ila_1/probe44 [get_nets [list s_axi_wvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe45]
set_property port_width 1 [get_debug_ports u_ila_1/probe45]
connect_debug_port u_ila_1/probe45 [get_nets [list ui_rst]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_1]
