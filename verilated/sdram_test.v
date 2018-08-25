// File: sdram_test.v
// Generated by MyHDL 0.10
// Date: Sat Aug 25 11:56:07 2018


`timescale 1ns/10ps

module sdram_test (
    master_clk_i,
    sdram_clk_o,
    sdram_clk_i,
    led_status,
    i_uart_rx,
    o_uart_tx,
    pb_i,
    SdramCntl0_sd_intf_cke,
    SdramCntl0_sd_intf_we,
    SdramCntl0_sd_intf_addr,
    SdramCntl0_sd_intf_dqml,
    SdramCntl0_sd_intf_cas,
    SdramCntl0_sd_intf_dqmh,
    SdramCntl0_sd_intf_ras,
    SdramCntl0_sd_intf_bs,
    SdramCntl0_sd_intf_cs,
    SdramCntl0_sd_intf_dq
);

/* verilator lint_off UNUSED */
input master_clk_i;
/* verilator lint_off UNUSED */
output sdram_clk_o;
wire sdram_clk_o;
input sdram_clk_i;
output [3:0] led_status;
reg [3:0] led_status;
input i_uart_rx;
output o_uart_tx;
reg o_uart_tx;
input pb_i;
output SdramCntl0_sd_intf_cke;
reg SdramCntl0_sd_intf_cke;
output SdramCntl0_sd_intf_we;
reg SdramCntl0_sd_intf_we;
output [12:0] SdramCntl0_sd_intf_addr;
reg [12:0] SdramCntl0_sd_intf_addr;
output SdramCntl0_sd_intf_dqml;
reg SdramCntl0_sd_intf_dqml;
output SdramCntl0_sd_intf_cas;
reg SdramCntl0_sd_intf_cas;
output SdramCntl0_sd_intf_dqmh;
reg SdramCntl0_sd_intf_dqmh;
output SdramCntl0_sd_intf_ras;
reg SdramCntl0_sd_intf_ras;
output [1:0] SdramCntl0_sd_intf_bs;
reg [1:0] SdramCntl0_sd_intf_bs;
output SdramCntl0_sd_intf_cs;
reg SdramCntl0_sd_intf_cs;
inout [15:0] SdramCntl0_sd_intf_dq;
wire [15:0] SdramCntl0_sd_intf_dq;

reg pb_prev;
reg pb_debounced;
reg initialized;
reg [5:0] debounce_cntr;
wire clk;
/* verilator lint_off UNUSED */
reg o_TX_Done;
/* verilator lint_off UNUSED */
reg clk50MHz;
reg w_TX_Active;
wire reset;
reg w_TX_Serial;
reg [2:0] state_rx=0;
reg w_RX_DV;
reg [7:0] w_RX_Byte;
reg [2:0] state_tx=0;
reg [11:0] uart_tx0_0_r_Clock_Count;
reg [2:0] uart_tx0_0_r_Bit_Index;
reg [7:0] uart_tx0_0_r_TX_data;
reg uart_tx0_0_r_TX_Active;
reg uart_tx0_0_r_TX_Done;
reg [2:0] SdramCntl0_cmd_r;
reg [12:0] SdramCntl0_sAddr_x;
reg [2:0] SdramCntl0_cmd_x;
reg [1:0] SdramCntl0_activeBank_r;
reg [12:0] SdramCntl0_sAddr_r;
reg [15:0] SdramCntl0_sdramData_x;
reg SdramCntl0_activateInProgress_s;
wire SdramCntl0_host_intf_done_o;
reg SdramCntl0_sDataDir_x;
reg SdramCntl0_sDataDir_r;
wire [1:0] SdramCntl0_ba_x;
reg [4:0] SdramCntl0_rdPipeline_r;
wire [12:0] SdramCntl0_row_s;
reg [13:0] SdramCntl0_rfshCntr_x;
reg [1:0] SdramCntl0_ba_r;
reg [4:0] SdramCntl0_rdPipeline_x;
wire [15:0] SdramCntl0_host_intf_data_o;
reg [13:0] SdramCntl0_rfshCntr_r;
reg [15:0] SdramCntl0_sDriver;
reg [1:0] SdramCntl0_activeBank_x;
wire SdramCntl0_host_intf_wr_i;
reg SdramCntl0_doActivate_s;
wire [15:0] SdramCntl0_host_intf_data_i;
wire [1:0] SdramCntl0_bank_s;
reg [8:0] SdramCntl0_refTimer_r;
reg SdramCntl0_rdInProgress_s;
reg [8:0] SdramCntl0_refTimer_x;
reg SdramCntl0_writeInProgress_s;
reg [2:0] SdramCntl0_state_x;
reg [15:0] SdramCntl0_sData_r;
wire [8:0] SdramCntl0_col_s;
reg [2:0] SdramCntl0_state_r;
wire [15:0] SdramCntl0_sData_x;
reg [9:0] SdramCntl0_timer_x;
reg [4:0] SdramCntl0_wrPipeline_x;
reg [1:0] SdramCntl0_wrTimer_x;
wire SdramCntl0_host_intf_rdPending_o;
wire [23:0] SdramCntl0_host_intf_addr_i;
reg [4:0] SdramCntl0_wrPipeline_r;
reg [15:0] SdramCntl0_sdramData_r;
reg [1:0] SdramCntl0_wrTimer_r;
reg [9:0] SdramCntl0_timer_r;
wire SdramCntl0_host_intf_rd_i;
reg [1:0] SdramCntl0_rasTimer_x;
reg [1:0] SdramCntl0_rasTimer_r;
reg uart_rx0_0_r_RX_DV;
reg [11:0] uart_rx0_0_r_Clock_Count;
reg [2:0] uart_rx0_0_r_Bit_Index;
reg [7:0] memory_test0_status_o;
reg memory_test0_rand_load;
reg memory_test0_rand_enable;
reg memory_test0_rd_enable;
wire [15:0] memory_test0_rand_val;
reg [1:0] memory_test0_test_state;
reg [26:0] memory_test0_address;
wire memory_test0_host_intf_rst_i;
reg memory_test0_wr_enable;
reg memory_test0_error;
reg [15:0] memory_test0_uniform_rand_gen0_shfreg;
reg [12:0] SdramCntl0_activeRow_x [0:4-1];
reg [12:0] SdramCntl0_activeRow_r [0:4-1];
reg SdramCntl0_activeFlag_x [0:4-1];
reg SdramCntl0_activeFlag_r [0:4-1];

assign SdramCntl0_sd_intf_dq = SdramCntl0_sDriver;



assign reset = ((!initialized) || (!pb_debounced));


always @(w_TX_Active, w_TX_Serial) begin: SDRAM_TEST_FORCEHI0_COMB
    if (w_TX_Active) begin
        o_uart_tx = w_TX_Serial;
    end
    else begin
        o_uart_tx = 1'b1;
    end
end



assign sdram_clk_o = clk50MHz;
assign clk = sdram_clk_i;


always @(posedge master_clk_i) begin: SDRAM_TEST_DIV2
    clk50MHz <= (!clk50MHz);
end


always @(posedge clk) begin: SDRAM_TEST_DEBOUNCE_PB
    if ((pb_i != pb_prev)) begin
        debounce_cntr <= (49 - 1);
    end
    else begin
        if ((debounce_cntr == 0)) begin
            pb_debounced <= pb_i;
            debounce_cntr <= 1;
        end
        else begin
            debounce_cntr <= (debounce_cntr - 1);
        end
    end
    pb_prev <= pb_i;
end


always @(posedge clk) begin: SDRAM_TEST_INTERNAL_RESET
    if ((initialized == 1'b0)) begin
        initialized <= (!initialized);
    end
end


always @(posedge sdram_clk_o) begin: SDRAM_TEST_UART_TX0_0_SEND
    case (state_tx)
        3'b000: begin
            // Drive Line High for TX_IDLE
            w_TX_Serial <= 1;
            uart_tx0_0_r_TX_Done <= 0;
            uart_tx0_0_r_Bit_Index <= 0;
            uart_tx0_0_r_Clock_Count <= 0;
            if ((w_RX_DV == 1)) begin
                uart_tx0_0_r_TX_Active <= 1;
                uart_tx0_0_r_TX_data <= w_RX_Byte;
                state_tx <= 3'b001;
            end
            else begin
                state_tx <= 3'b000;
                // End of TX TX_IDLE state
                // Start of TX TX_START_BIT state
            end
        end
        3'b001: begin
            w_TX_Serial <= 0;
            if (($signed({1'b0, uart_tx0_0_r_Clock_Count}) < (434 - 1))) begin
                uart_tx0_0_r_Clock_Count <= (uart_tx0_0_r_Clock_Count + 1);
                state_tx <= 3'b001;
            end
            else begin
                uart_tx0_0_r_Clock_Count <= 0;
                state_tx <= 3'b010;
                // End of TX TX_START_BIT state_tx
                // Start of TX TX_DATA_BITS state_tx
            end
        end
        3'b010: begin
            w_TX_Serial <= uart_tx0_0_r_TX_data[uart_tx0_0_r_Bit_Index];
            if (($signed({1'b0, uart_tx0_0_r_Clock_Count}) < (434 - 1))) begin
                uart_tx0_0_r_Clock_Count <= (uart_tx0_0_r_Clock_Count + 1);
                state_tx <= 3'b010;
            end
            else begin
                uart_tx0_0_r_Clock_Count <= 0;
                if ((uart_tx0_0_r_Bit_Index < 7)) begin
                    uart_tx0_0_r_Bit_Index <= (uart_tx0_0_r_Bit_Index + 1);
                    state_tx <= 3'b010;
                end
                else begin
                    uart_tx0_0_r_Bit_Index <= 0;
                    state_tx <= 3'b011;
                end
                // End of TX TX_DATA_BITS state_tx
                // Start of TX TX_STOP_BIT state_tx
            end
        end
        3'b011: begin
            w_TX_Serial <= 1;
            if (($signed({1'b0, uart_tx0_0_r_Clock_Count}) < (434 - 1))) begin
                uart_tx0_0_r_Clock_Count <= (uart_tx0_0_r_Clock_Count + 1);
                state_tx <= 3'b011;
            end
            else begin
                uart_tx0_0_r_TX_Done <= 1;
                uart_tx0_0_r_Clock_Count <= 0;
                state_tx <= 3'b100;
                uart_tx0_0_r_TX_Active <= 0;
                // End of TX TX_STOP_BIT state_tx
                // Start of TX TX_CLEANUP state_tx
            end
        end
        3'b100: begin
            uart_tx0_0_r_TX_Done <= 1;
            state_tx <= 3'b000;
        end
        default: begin
            state_tx <= 3'b000;
        end
    endcase
    w_TX_Active <= uart_tx0_0_r_TX_Active;
    o_TX_Done <= uart_tx0_0_r_TX_Done;
end


always @(SdramCntl0_activeRow_r[0], SdramCntl0_activeRow_r[1], SdramCntl0_activeRow_r[2], SdramCntl0_activeRow_r[3], SdramCntl0_row_s, SdramCntl0_sAddr_r, SdramCntl0_activateInProgress_s, SdramCntl0_activeBank_r, SdramCntl0_sDataDir_r, SdramCntl0_ba_x, SdramCntl0_rdPipeline_r, SdramCntl0_ba_r, SdramCntl0_rfshCntr_r, SdramCntl0_host_intf_wr_i, SdramCntl0_doActivate_s, SdramCntl0_bank_s, SdramCntl0_refTimer_r, SdramCntl0_rdInProgress_s, SdramCntl0_writeInProgress_s, SdramCntl0_col_s, SdramCntl0_state_r, SdramCntl0_wrTimer_r, SdramCntl0_timer_r, SdramCntl0_host_intf_rd_i, SdramCntl0_rasTimer_r, SdramCntl0_activeFlag_r[0], SdramCntl0_activeFlag_r[1], SdramCntl0_activeFlag_r[2], SdramCntl0_activeFlag_r[3]) begin: SDRAM_TEST_SDRAMCNTL0_COMB_FUNC
    integer index;
    SdramCntl0_rdPipeline_x = {1'b0, SdramCntl0_rdPipeline_r[(3 + 2)-1:1]};
    SdramCntl0_wrPipeline_x = 5'h0;
    if ((SdramCntl0_rasTimer_r != 0)) begin
        SdramCntl0_rasTimer_x = (SdramCntl0_rasTimer_r - 1);
    end
    else begin
        SdramCntl0_rasTimer_x = SdramCntl0_rasTimer_r;
    end
    if ((SdramCntl0_wrTimer_r != 0)) begin
        SdramCntl0_wrTimer_x = (SdramCntl0_wrTimer_r - 1);
    end
    else begin
        SdramCntl0_wrTimer_x = SdramCntl0_wrTimer_r;
    end
    if ((SdramCntl0_refTimer_r != 0)) begin
        SdramCntl0_refTimer_x = (SdramCntl0_refTimer_r - 1);
        SdramCntl0_rfshCntr_x = SdramCntl0_rfshCntr_r;
    end
    else begin
        SdramCntl0_refTimer_x = 391;
        SdramCntl0_rfshCntr_x = (SdramCntl0_rfshCntr_r + 1);
    end
    SdramCntl0_cmd_x = 7;
    SdramCntl0_state_x = SdramCntl0_state_r;
    SdramCntl0_sAddr_x = SdramCntl0_sAddr_r;
    SdramCntl0_activeBank_x = SdramCntl0_activeBank_r;
    SdramCntl0_sDataDir_x = SdramCntl0_sDataDir_r;
    for (index=0; index<(2 ** 2); index=index+1) begin
        SdramCntl0_activeFlag_x[index] = SdramCntl0_activeFlag_r[index];
        SdramCntl0_activeRow_x[index] = SdramCntl0_activeRow_r[index];
    end
    if ((SdramCntl0_timer_r != 0)) begin
        SdramCntl0_timer_x = (SdramCntl0_timer_r - 1);
        SdramCntl0_cmd_x = 7;
    end
    else begin
        SdramCntl0_timer_x = SdramCntl0_timer_r;
        case (SdramCntl0_state_r)
            3'b000: begin
                SdramCntl0_timer_x = 1000;
                SdramCntl0_state_x = 3'b001;
            end
            3'b001: begin
                SdramCntl0_cmd_x = 2;
                SdramCntl0_timer_x = 1;
                SdramCntl0_state_x = 3'b011;
                SdramCntl0_sAddr_x = 512;
                SdramCntl0_rfshCntr_x = 8;
            end
            3'b011: begin
                SdramCntl0_cmd_x = 1;
                SdramCntl0_timer_x = 4;
                SdramCntl0_rfshCntr_x = (SdramCntl0_rfshCntr_r - 1);
                if ((SdramCntl0_rfshCntr_r == 1)) begin
                    SdramCntl0_state_x = 3'b010;
                end
            end
            3'b010: begin
                SdramCntl0_cmd_x = 0;
                SdramCntl0_timer_x = 2;
                SdramCntl0_state_x = 3'b100;
                SdramCntl0_sAddr_x = 48;
            end
            3'b100: begin
                if ((SdramCntl0_rfshCntr_r != 0)) begin
                    if (((SdramCntl0_activateInProgress_s == 1'b0) && (SdramCntl0_writeInProgress_s == 1'b0) && (SdramCntl0_rdInProgress_s == 1'b0))) begin
                        SdramCntl0_cmd_x = 2;
                        SdramCntl0_timer_x = 1;
                        SdramCntl0_state_x = 3'b110;
                        SdramCntl0_sAddr_x = 512;
                        for (index=0; index<(2 ** 2); index=index+1) begin
                            SdramCntl0_activeFlag_x[index] = 1'b0;
                        end
                    end
                end
                else if ((SdramCntl0_host_intf_rd_i == 1'b1)) begin
                    if ((SdramCntl0_ba_x == SdramCntl0_ba_r)) begin
                        if ((SdramCntl0_doActivate_s == 1'b1)) begin
                            if (((SdramCntl0_activateInProgress_s == 1'b0) && (SdramCntl0_writeInProgress_s == 1'b0) && (SdramCntl0_rdInProgress_s == 1'b0))) begin
                                SdramCntl0_cmd_x = 2;
                                SdramCntl0_timer_x = 1;
                                SdramCntl0_state_x = 3'b101;
                                SdramCntl0_sAddr_x = 0;
                                SdramCntl0_activeFlag_x[SdramCntl0_bank_s] = 1'b0;
                            end
                        end
                        else if ((SdramCntl0_rdInProgress_s == 1'b0)) begin
                            SdramCntl0_cmd_x = 5;
                            SdramCntl0_sDataDir_x = 1'b0;
                            SdramCntl0_sAddr_x = SdramCntl0_col_s;
                            SdramCntl0_rdPipeline_x = {1'b1, SdramCntl0_rdPipeline_r[(3 + 2)-1:1]};
                        end
                    end
                end
                else if ((SdramCntl0_host_intf_wr_i == 1'b1)) begin
                    if ((SdramCntl0_ba_x == SdramCntl0_ba_r)) begin
                        if ((SdramCntl0_doActivate_s == 1'b1)) begin
                            if (((SdramCntl0_activateInProgress_s == 1'b0) && (SdramCntl0_writeInProgress_s == 1'b0) && (SdramCntl0_rdInProgress_s == 1'b0))) begin
                                SdramCntl0_cmd_x = 2;
                                SdramCntl0_timer_x = 1;
                                SdramCntl0_state_x = 3'b101;
                                SdramCntl0_sAddr_x = 0;
                                SdramCntl0_activeFlag_x[SdramCntl0_bank_s] = 1'b0;
                            end
                        end
                        else if ((SdramCntl0_rdInProgress_s == 1'b0)) begin
                            SdramCntl0_cmd_x = 4;
                            SdramCntl0_sDataDir_x = 1'b1;
                            SdramCntl0_sAddr_x = SdramCntl0_col_s;
                            SdramCntl0_wrPipeline_x = 5'h1;
                            SdramCntl0_wrTimer_x = 2;
                        end
                    end
                end
                else begin
                    SdramCntl0_cmd_x = 7;
                    SdramCntl0_state_x = 3'b100;
                end
            end
            3'b101: begin
                SdramCntl0_cmd_x = 3;
                SdramCntl0_timer_x = 1;
                SdramCntl0_state_x = 3'b100;
                SdramCntl0_rasTimer_x = 3;
                SdramCntl0_sAddr_x = SdramCntl0_row_s;
                SdramCntl0_activeBank_x = SdramCntl0_bank_s;
                SdramCntl0_activeRow_x[SdramCntl0_bank_s] = SdramCntl0_row_s;
                SdramCntl0_activeFlag_x[SdramCntl0_bank_s] = 1'b1;
            end
            3'b110: begin
                SdramCntl0_cmd_x = 1;
                SdramCntl0_timer_x = 4;
                SdramCntl0_state_x = 3'b100;
                SdramCntl0_rfshCntr_x = (SdramCntl0_rfshCntr_r - 1);
            end
            default: begin
                SdramCntl0_state_x = 3'b000;
            end
        endcase
    end
end


always @(posedge clk, posedge memory_test0_host_intf_rst_i) begin: SDRAM_TEST_SDRAMCNTL0_SEQ_FUNC
    integer index;
    if (memory_test0_host_intf_rst_i == 1) begin
        SdramCntl0_cmd_r <= 7;
        SdramCntl0_rdPipeline_r <= 0;
        SdramCntl0_sdramData_r <= 0;
        SdramCntl0_ba_r <= 0;
        SdramCntl0_wrPipeline_r <= 0;
        SdramCntl0_sData_r <= 0;
        SdramCntl0_wrTimer_r <= 0;
        SdramCntl0_rfshCntr_r <= 0;
        SdramCntl0_sAddr_r <= 0;
        SdramCntl0_timer_r <= 0;
        SdramCntl0_activeRow_r[0] <= 0;
        SdramCntl0_activeRow_r[1] <= 0;
        SdramCntl0_activeRow_r[2] <= 0;
        SdramCntl0_activeRow_r[3] <= 0;
        SdramCntl0_activeBank_r <= 0;
        SdramCntl0_refTimer_r <= 391;
        SdramCntl0_state_r <= 3'b000;
        SdramCntl0_rasTimer_r <= 0;
        SdramCntl0_sDataDir_r <= 0;
        SdramCntl0_activeFlag_r[0] <= 0;
        SdramCntl0_activeFlag_r[1] <= 0;
        SdramCntl0_activeFlag_r[2] <= 0;
        SdramCntl0_activeFlag_r[3] <= 0;
    end
    else begin
        SdramCntl0_state_r <= SdramCntl0_state_x;
        SdramCntl0_cmd_r <= SdramCntl0_cmd_x;
        SdramCntl0_sAddr_r <= SdramCntl0_sAddr_x;
        SdramCntl0_sData_r <= SdramCntl0_sData_x;
        SdramCntl0_sDataDir_r <= SdramCntl0_sDataDir_x;
        SdramCntl0_activeBank_r <= SdramCntl0_activeBank_x;
        SdramCntl0_sdramData_r <= SdramCntl0_sdramData_x;
        SdramCntl0_wrPipeline_r <= SdramCntl0_wrPipeline_x;
        SdramCntl0_rdPipeline_r <= SdramCntl0_rdPipeline_x;
        SdramCntl0_ba_r <= SdramCntl0_ba_x;
        SdramCntl0_timer_r <= SdramCntl0_timer_x;
        SdramCntl0_rasTimer_r <= SdramCntl0_rasTimer_x;
        SdramCntl0_refTimer_r <= SdramCntl0_refTimer_x;
        SdramCntl0_wrTimer_r <= SdramCntl0_wrTimer_x;
        SdramCntl0_rfshCntr_r <= SdramCntl0_rfshCntr_x;
        for (index=0; index<(2 ** 2); index=index+1) begin
            SdramCntl0_activeRow_r[index] <= SdramCntl0_activeRow_x[index];
            SdramCntl0_activeFlag_r[index] <= SdramCntl0_activeFlag_x[index];
        end
    end
end


always @(SdramCntl0_cmd_r, SdramCntl0_sData_r, SdramCntl0_sAddr_r, SdramCntl0_bank_s, SdramCntl0_sDataDir_r) begin: SDRAM_TEST_SDRAMCNTL0_SDRAM_PIN_MAP
    SdramCntl0_sd_intf_cke = 1;
    SdramCntl0_sd_intf_cs = 0;
    SdramCntl0_sd_intf_ras = SdramCntl0_cmd_r[2];
    SdramCntl0_sd_intf_cas = SdramCntl0_cmd_r[1];
    SdramCntl0_sd_intf_we = SdramCntl0_cmd_r[0];
    SdramCntl0_sd_intf_bs = SdramCntl0_bank_s;
    SdramCntl0_sd_intf_addr = SdramCntl0_sAddr_r;
    if ((SdramCntl0_sDataDir_r == 1'b1)) begin
        SdramCntl0_sDriver = SdramCntl0_sData_r;
    end
    else begin
        SdramCntl0_sDriver = 'bz;
    end
    SdramCntl0_sd_intf_dqml = 0;
    SdramCntl0_sd_intf_dqmh = 0;
end



assign SdramCntl0_host_intf_done_o = (SdramCntl0_rdPipeline_r[0] || SdramCntl0_wrPipeline_r[0]);
assign SdramCntl0_host_intf_data_o = SdramCntl0_sdramData_r;
assign SdramCntl0_host_intf_rdPending_o = SdramCntl0_rdInProgress_s;
assign SdramCntl0_sData_x = SdramCntl0_host_intf_data_i;



assign SdramCntl0_bank_s = SdramCntl0_host_intf_addr_i[((2 + 13) + 9)-1:(13 + 9)];
assign SdramCntl0_ba_x = SdramCntl0_host_intf_addr_i[((2 + 13) + 9)-1:(13 + 9)];
assign SdramCntl0_row_s = SdramCntl0_host_intf_addr_i[(13 + 9)-1:9];
assign SdramCntl0_col_s = SdramCntl0_host_intf_addr_i[9-1:0];


always @(SdramCntl0_activeRow_r[0], SdramCntl0_activeRow_r[1], SdramCntl0_activeRow_r[2], SdramCntl0_activeRow_r[3], SdramCntl0_rdPipeline_r, SdramCntl0_bank_s, SdramCntl0_sdramData_r, SdramCntl0_activeBank_r, SdramCntl0_wrTimer_r, SdramCntl0_sd_intf_dq, SdramCntl0_row_s, SdramCntl0_rasTimer_r, SdramCntl0_activeFlag_r[0], SdramCntl0_activeFlag_r[1], SdramCntl0_activeFlag_r[2], SdramCntl0_activeFlag_r[3]) begin: SDRAM_TEST_SDRAMCNTL0_DO_ACTIVE
    if (((SdramCntl0_bank_s != SdramCntl0_activeBank_r) || (SdramCntl0_row_s != SdramCntl0_activeRow_r[SdramCntl0_bank_s]) || (SdramCntl0_activeFlag_r[SdramCntl0_bank_s] == 1'b0))) begin
        SdramCntl0_doActivate_s = 1'b1;
    end
    else begin
        SdramCntl0_doActivate_s = 1'b0;
    end
    if ((SdramCntl0_rdPipeline_r[1] == 1'b1)) begin
        SdramCntl0_sdramData_x = SdramCntl0_sd_intf_dq;
    end
    else begin
        SdramCntl0_sdramData_x = SdramCntl0_sdramData_r;
    end
    if ((SdramCntl0_rasTimer_r != 0)) begin
        SdramCntl0_activateInProgress_s = 1'b1;
    end
    else begin
        SdramCntl0_activateInProgress_s = 1'b0;
    end
    if ((SdramCntl0_wrTimer_r != 0)) begin
        SdramCntl0_writeInProgress_s = 1'b1;
    end
    else begin
        SdramCntl0_writeInProgress_s = 1'b0;
    end
    if ((SdramCntl0_rdPipeline_r[(3 + 2)-1:1] != 0)) begin
        SdramCntl0_rdInProgress_s = 1'b1;
    end
    else begin
        SdramCntl0_rdInProgress_s = 1'b0;
    end
end


always @(posedge sdram_clk_o) begin: SDRAM_TEST_UART_RX0_0_RECV
    case (state_rx)
        3'b000: begin
            // Drive Line High for RX_IDLE
            uart_rx0_0_r_RX_DV <= 0;
            uart_rx0_0_r_Bit_Index <= 0;
            uart_rx0_0_r_Clock_Count <= 0;
            if ((i_uart_rx == 0)) begin
                state_rx <= 3'b001;
            end
            else begin
                state_rx <= 3'b000;
                // End of RX RX_IDLE state_rx
                // Start of RX RX_START_BIT state_rx
            end
        end
        3'b001: begin
            if (($signed({1'b0, uart_rx0_0_r_Clock_Count}) == ((434 - 1) / 2))) begin
                if ((i_uart_rx == 0)) begin
                    uart_rx0_0_r_Clock_Count <= 0;
                    state_rx <= 3'b010;
                end
                else begin
                    state_rx <= 3'b000;
                end
            end
            else begin
                uart_rx0_0_r_Clock_Count <= (uart_rx0_0_r_Clock_Count + 1);
                state_rx <= 3'b001;
                // End of RX RX_START_BIT state_rx
                // Start of RX RX_DATA_BITS state_rx
            end
        end
        3'b010: begin
            if (($signed({1'b0, uart_rx0_0_r_Clock_Count}) < (434 - 1))) begin
                uart_rx0_0_r_Clock_Count <= (uart_rx0_0_r_Clock_Count + 1);
                state_rx <= 3'b010;
            end
            else begin
                uart_rx0_0_r_Clock_Count <= 0;
                w_RX_Byte[uart_rx0_0_r_Bit_Index] <= i_uart_rx;
                if ((uart_rx0_0_r_Bit_Index < 7)) begin
                    uart_rx0_0_r_Bit_Index <= (uart_rx0_0_r_Bit_Index + 1);
                    state_rx <= 3'b010;
                end
                else begin
                    uart_rx0_0_r_Bit_Index <= 0;
                    state_rx <= 3'b011;
                end
                // End of RX RX_DATA_BITS state_rx
                // Start of RX RX_STOP_BIT state_rx
            end
        end
        3'b011: begin
            if (($signed({1'b0, uart_rx0_0_r_Clock_Count}) < (434 - 1))) begin
                uart_rx0_0_r_Clock_Count <= (uart_rx0_0_r_Clock_Count + 1);
                state_rx <= 3'b011;
            end
            else begin
                uart_rx0_0_r_RX_DV <= 1;
                uart_rx0_0_r_Clock_Count <= 0;
                state_rx <= 3'b100;
                // End of RX RX_STOP_BIT state_rx
                // Start of RX RX_CLEANUP state_rx
            end
        end
        3'b100: begin
            state_rx <= 3'b000;
            uart_rx0_0_r_RX_DV <= 0;
        end
        default: begin
            state_rx <= 3'b000;
        end
    endcase
    w_RX_DV <= uart_rx0_0_r_RX_DV;
end



assign memory_test0_rand_val = memory_test0_uniform_rand_gen0_shfreg;


always @(posedge clk) begin: SDRAM_TEST_MEMORY_TEST0_UNIFORM_RAND_GEN0_RAND_SHIFT
    integer i;
    integer xor_bit;
    integer bits;
    bits = (memory_test0_uniform_rand_gen0_shfreg & 53256);
    xor_bit = 0;
    for (i=0; i<16; i=i+1) begin
        xor_bit = (xor_bit ^ bits[i]);
    end
    if (memory_test0_rand_load) begin
        memory_test0_uniform_rand_gen0_shfreg <= 42;
    end
    else if (memory_test0_rand_enable) begin
        memory_test0_uniform_rand_gen0_shfreg[16-1:1] <= memory_test0_uniform_rand_gen0_shfreg[(16 - 1)-1:0];
        memory_test0_uniform_rand_gen0_shfreg[0] <= xor_bit;
    end
end


always @(posedge clk) begin: SDRAM_TEST_MEMORY_TEST0_SDRAM_TESTER
    if ((reset == 1'b1)) begin
        memory_test0_error <= 1'b0;
        memory_test0_test_state <= 2'b01;
        memory_test0_status_o <= 49;
        led_status <= 4'h1;
        memory_test0_address <= 0;
        memory_test0_rand_load <= 1;
    end
    else if ((memory_test0_test_state == 2'b01)) begin
        memory_test0_rand_load <= 0;
        memory_test0_rand_enable <= 0;
        memory_test0_status_o <= 50;
        led_status <= 4'h2;
        if ((SdramCntl0_host_intf_done_o == 1'b0)) begin
            memory_test0_wr_enable <= 1'b1;
        end
        else begin
            memory_test0_wr_enable <= 1'b0;
            memory_test0_rand_enable <= 1;
            memory_test0_address <= (memory_test0_address + 1);
            if ((memory_test0_address == 16777215)) begin
                memory_test0_test_state <= 2'b10;
                memory_test0_address <= 0;
                memory_test0_rand_load <= 1;
                memory_test0_error <= 1'b0;
            end
        end
    end
    else if ((memory_test0_test_state == 2'b10)) begin
        memory_test0_rand_load <= 0;
        memory_test0_rand_enable <= 0;
        memory_test0_status_o <= 51;
        led_status <= 4'h4;
        if ((SdramCntl0_host_intf_done_o == 1'b0)) begin
            memory_test0_rd_enable <= 1'b1;
        end
        else begin
            memory_test0_rd_enable <= 1'b0;
            memory_test0_rand_enable <= 1;
            memory_test0_address <= (memory_test0_address + 1);
            if ((memory_test0_rand_val != SdramCntl0_host_intf_data_o)) begin
                memory_test0_error <= 1'b1;
            end
            if ((memory_test0_address == 16777215)) begin
                memory_test0_test_state <= 2'b11;
            end
        end
    end
    else begin
        memory_test0_rand_load <= 0;
        memory_test0_rand_enable <= 0;
        if ((memory_test0_error == 1'b1)) begin
            memory_test0_status_o <= 70;
            led_status <= 4'h8;
        end
        else begin
            memory_test0_status_o <= 79;
            led_status <= 4'hf;
        end
    end
end



assign memory_test0_host_intf_rst_i = reset;
assign SdramCntl0_host_intf_wr_i = (memory_test0_wr_enable && (!SdramCntl0_host_intf_done_o));
assign SdramCntl0_host_intf_rd_i = (memory_test0_rd_enable && (!SdramCntl0_host_intf_done_o));
assign SdramCntl0_host_intf_data_i = memory_test0_rand_val;
assign SdramCntl0_host_intf_addr_i = memory_test0_address;

endmodule
