# MIT license
# 
# Copyright (C) 2016 by XESS Corporation.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

from myhdl import *
#from led_digits_display import *
#from simple_modules import *
from ice40_primitives import *
from SDRAM_Controller.SdramCntl import *
from SDRAM_Controller.sdram import *
from SDRAM_Controller.host_intf import *
from SDRAM_Controller.sd_intf import *
from rand_gen import uniform_rand_gen

t_state_rx = enum('RX_IDLE', 'RX_START_BIT', 'RX_DATA_BITS','RX_STOP_BIT','RX_CLEANUP')
t_state_tx = enum('TX_IDLE', 'TX_START_BIT', 'TX_DATA_BITS', 'TX_STOP_BIT', 'TX_CLEANUP')

def uart_tx(i_Clock,i_TX_DV,i_TX_Byte,o_TX_Active,o_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=None):
	r_TX_Done = Signal(bool(0))
	r_TX_Active = Signal(bool(0))
	r_Clock_Count = Signal(intbv(0)[12:])
	r_TX_data = Signal(intbv(0)[8:])
	r_Bit_Index = Signal(intbv(0)[3:])
	"""
	r_SM_Main = Signal(intbv(0)[3:])
	
	TX_IDLE = Signal(intbv(0)[3:])
	TX_CLEANUP = Signal(intbv(0)[3:])
	
	TX_IDLE = 0
	TX_TX_START_BIT = 1
	TX_DATA_BITS = 2
	TX_STOP_BIT = 3
	TX_CLEANUP = 4
	"""
	@always(i_Clock.posedge)
	def send():
		if(state_tx==t_state_tx.TX_IDLE):
			"""Drive Line High for TX_IDLE"""
		
			o_TX_Serial.next = 1
			r_TX_Done.next = 0
			r_Bit_Index.next = 0
			r_Clock_Count.next = 0
			if(i_TX_DV == 1):
				r_TX_Active.next = 1
				r_TX_data.next = i_TX_Byte
				state_tx.next = t_state_tx.TX_START_BIT
			else:
				state_tx.next = t_state_tx.TX_IDLE 
				"""
				End of TX TX_IDLE state
				Start of TX TX_START_BIT state
				"""
		elif (state_tx==t_state_tx.TX_START_BIT):
			o_TX_Serial.next = 0
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_tx.next = t_state_tx.TX_START_BIT
			else:
				r_Clock_Count.next = 0
				state_tx.next = t_state_tx.TX_DATA_BITS
				"""
				End of TX TX_START_BIT state_tx
				Start of TX TX_DATA_BITS state_tx
				"""
		elif (state_tx==t_state_tx.TX_DATA_BITS):
			o_TX_Serial.next = r_TX_data[r_Bit_Index]
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_tx.next = t_state_tx.TX_DATA_BITS
			else:
				r_Clock_Count.next = 0
				if (r_Bit_Index < 7):
					r_Bit_Index.next = r_Bit_Index + 1
					state_tx.next = t_state_tx.TX_DATA_BITS
				else:
					r_Bit_Index.next = 0
					state_tx.next = t_state_tx.TX_STOP_BIT
				"""
				End of TX TX_DATA_BITS state_tx
				Start of TX TX_STOP_BIT state_tx
				"""
					
		elif (state_tx==t_state_tx.TX_STOP_BIT):
			o_TX_Serial.next = 1
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_tx.next = t_state_tx.TX_STOP_BIT
			else:
				r_TX_Done.next = 1
				r_Clock_Count.next = 0
				state_tx.next = t_state_tx.TX_CLEANUP
				r_TX_Active.next = 0
				"""
				End of TX TX_STOP_BIT state_tx
				Start of TX TX_CLEANUP state_tx
				"""
		elif (state_tx==t_state_tx.TX_CLEANUP):
			r_TX_Done.next = 1
			state_tx.next = t_state_tx.TX_IDLE
		else:
			state_tx.next = t_state_tx.TX_IDLE
		o_TX_Active.next = r_TX_Active
		o_TX_Done.next = r_TX_Done
				
				
				
			
				
				


	return send
def uart_rx(i_Clock,i_RX_Serial,o_RX_DV,o_RX_Byte,state_rx,CLKS_PER_BIT=None):
	r_RX_DV = Signal(bool(0))
	r_Clock_Count = Signal(intbv(0)[12:])
	r_RX_data = Signal(intbv(0)[8:])
	r_RX_Byte = Signal(intbv(0)[8:])
	r_Bit_Index = Signal(intbv(0)[3:])
	"""
	r_SM_Main = Signal(intbv(0)[3:])
	
	RX_START_BIT = Signal(intbv(0)[3:])
	DATA_BITS = Signal(intbv(0)[3:])
	STOP_BIT = Signal(intbv(0)[3:])
	IDLE = Signal(intbv(0)[3:])
	CLEANUP = Signal(intbv(0)[3:])
	
	IDLE = 0
	START_BIT = 1
	DATA_BITS = 2
	STOP_BIT = 3
	CLEANUP = 4
	"""
	@always(i_Clock.posedge)
	def recv():
		if(state_rx==t_state_rx.RX_IDLE):
			"""Drive Line High for RX_IDLE"""
		
			r_RX_DV.next = 0
			r_Bit_Index.next = 0
			r_Clock_Count.next = 0
			if(i_RX_Serial == 0):
				state_rx.next = t_state_rx.RX_START_BIT
			else:
				state_rx.next = t_state_rx.RX_IDLE 
				"""
				End of RX RX_IDLE state_rx
				Start of RX RX_START_BIT state_rx
				"""				
		elif (state_rx==t_state_rx.RX_START_BIT):
			if (r_Clock_Count == (CLKS_PER_BIT -1)//2):
				if ( i_RX_Serial == 0):
					r_Clock_Count.next = 0
					state_rx.next = t_state_rx.RX_DATA_BITS
				else:
					state_rx.next = t_state_rx.RX_IDLE
			else:
				r_Clock_Count.next = r_Clock_Count + 1
				state_rx.next = t_state_rx.RX_START_BIT
				"""
				End of RX RX_START_BIT state_rx
				Start of RX RX_DATA_BITS state_rx
				"""				
		elif (state_rx==t_state_rx.RX_DATA_BITS):
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_rx.next = t_state_rx.RX_DATA_BITS
			else:
				r_Clock_Count.next = 0
				r_RX_Byte[r_Bit_Index].next = i_RX_Serial
				if (r_Bit_Index < 7):
					r_Bit_Index.next = r_Bit_Index + 1
					state_rx.next = t_state_rx.RX_DATA_BITS
				else:
					r_Bit_Index.next = 0
					state_rx.next = t_state_rx.RX_STOP_BIT
				"""
				End of RX RX_DATA_BITS state_rx
				Start of RX RX_STOP_BIT state_rx
				"""					
		elif (state_rx==t_state_rx.RX_STOP_BIT):
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_rx.next = t_state_rx.RX_STOP_BIT
			else:
				r_RX_DV.next = 1
				r_Clock_Count.next = 0
				state_rx.next = t_state_rx.RX_CLEANUP
				"""
				End of RX RX_STOP_BIT state_rx
				Start of RX RX_CLEANUP state_rx
				"""
		elif (state_rx==t_state_rx.RX_CLEANUP):
			state_rx.next = t_state_rx.RX_IDLE
			r_RX_DV.next = 0
		else:
			state_rx.next = t_state_rx.RX_IDLE
		o_RX_DV.next = r_RX_DV
		o_RX_Byte.next = r_RX_Byte

	return recv
def memory_test(clk_i, reset_i, status_o, led_status, host_intf):

    MAX_ADDRESS = 0xFFFFFF
    address = Signal(intbv(0)[len(host_intf.addr_i)+3:])
    wr_enable = Signal(bool(0))
    rd_enable = Signal(bool(0))
    rand_enable = Signal(bool(0))
    rand_load = Signal(bool(0))
    rand_seed = 42
    rand_val = Signal(intbv(0)[len(host_intf.data_i):])
    error = Signal(bool(False))
    testState = enum('INIT', 'WRITE', 'VERIFY', 'SHOW_RESULT')
    test_state = Signal(testState.INIT)

    rand_gen = uniform_rand_gen(clk_i, rand_enable, rand_load, rand_seed, rand_val)

    @always_seq(clk_i.posedge, reset=None)
    def sdram_tester():
        if reset_i == True:
            error.next = False
            test_state.next = testState.WRITE
            status_o.next = intbv(ord("1"),0,256)
            led_status.next = intbv('0001')[4:0]
            address.next = 0
            rand_load.next = 1
        elif test_state == testState.WRITE:
            rand_load.next = 0
            rand_enable.next = 0
            status_o.next = intbv(ord("2"),0,256)
            led_status.next = intbv('0010')[4:0]
            if host_intf.done_o == False:
                wr_enable.next = True
            else:
                wr_enable.next = False
                rand_enable.next = 1
                address.next = address + 1
                if address == MAX_ADDRESS:
                    test_state.next = testState.VERIFY
                    address.next = 0
                    rand_load.next = 1
                    error.next = False
        elif test_state == testState.VERIFY:
            rand_load.next = 0
            rand_enable.next = 0
            status_o.next = intbv(ord("3"),0,256)
            led_status.next = intbv('0100')[4:0]
            if host_intf.done_o == False:
                rd_enable.next = True
            else:
                rd_enable.next = False
                rand_enable.next = 1
                address.next = address + 1
                if rand_val != host_intf.data_o:
                    error.next = True
                if address == MAX_ADDRESS:
                    test_state.next = testState.SHOW_RESULT
        else:
            rand_load.next = 0
            rand_enable.next = 0
            if error == True:
                status_o.next = intbv(ord("F"),0,256)
                led_status.next = intbv('1000')[4:0]
            else:
                status_o.next = intbv(ord("O"),0,256)
                led_status.next = intbv('1111')[4:0]

    @always_comb
    def host_connections():
        host_intf.rst_i.next = reset_i
        host_intf.wr_i.next = wr_enable and not host_intf.done_o
        host_intf.rd_i.next = rd_enable and not host_intf.done_o
        host_intf.data_i.next = rand_val
        host_intf.addr_i.next = address

    return instances()


def sdram_test(master_clk_i, sdram_clk_o, sdram_clk_i,led_status, i_uart_rx, o_uart_tx, pb_i, sd_intf):
    clk50MHz = Signal(bool(0))
    w_TX_Serial = Signal(bool(0))
    w_TX_Active = Signal(bool(0))
    w_RX_DV = Signal(bool(0))
    w_RX_Byte = Signal(intbv(0)[8:])
    o_TX_Done = Signal(bool(0))
    state_tx = Signal(t_state_tx.TX_IDLE)
    state_rx = Signal(t_state_rx.RX_IDLE) 	
 
    clk = Signal(bool(0))
    
                 
    def forceHi(SigA,SigB,SigC):
	"""
	Drive UART line high when transmitter is not active
	          c           b              a
	assign o_uart_tx = w_TX_Active ? w_TX_Serial : 1'b1;
	sigtest_inst = sigtest(w_TX_Serial,w_TX_Active,o_uart_tx)
	"""

	@always_comb
	def comb():
		if(w_TX_Active):
			o_uart_tx.next = w_TX_Serial
		else:
			o_uart_tx.next = True
		
	return comb
	
    @always(master_clk_i.posedge)
    def div2():
		clk50MHz.next = not clk50MHz
    


	
    @always_comb
    def clock_routing():
		sdram_clk_o.next = clk50MHz
		clk.next = sdram_clk_i

    initialized = Signal(bool(False))

    @always_seq(clk.posedge, reset=None)
    def internal_reset():
        if initialized == False:
            initialized.next = not initialized
             

    # Get an internal version of the pushbutton signal and debounce it.
    pb, pb_prev, pb_debounced = [Signal(bool(0)) for _ in range(3)]
    #pb_inst = input_pin(pb_i, pb, pullup=True)
    #pb_debouncer = debouncer(clk, pb, pb_debounced, dbnc_window_g=0.01)
    DEBOUNCE_INTERVAL = int(49)
    debounce_cntr = Signal(intbv(DEBOUNCE_INTERVAL - 1, 0, DEBOUNCE_INTERVAL))

    @always_seq(clk.posedge, reset=None)
    def debounce_pb():
        if pb_i != pb_prev:
            debounce_cntr.next = DEBOUNCE_INTERVAL - 1
        else:
            if debounce_cntr == 0:
                pb_debounced.next = pb_i
                debounce_cntr.next = 1
            else:
                debounce_cntr.next = debounce_cntr - 1
        pb_prev.next = pb_i

    reset = Signal(bool(False))

    @always_comb
    def reset_logic():
        # Reset if not initialized upon startup or if pushbutton is pressed (low).
        reset.next = not initialized or not pb_debounced

    test_status = Signal(intbv(0)[8:])
    host_intf_inst = host_intf()
    memory_test_inst = memory_test(clk, reset, test_status, led_status, host_intf_inst)
    
    sdramCntl_inst = MySdramCntl(clk, host_intf_inst, sd_intf)
    uart_rx_inst = uart_rx(sdram_clk_o,i_uart_rx,w_RX_DV,w_RX_Byte,state_rx,CLKS_PER_BIT=434)
    uart_tx_inst = uart_tx(sdram_clk_o,w_RX_DV,w_RX_Byte,w_TX_Active,w_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=434)
    forceHi_inst = forceHi(w_TX_Serial,w_TX_Active,o_uart_tx)
 
    return instances()

@block
def ram(dout, din, addr, we, i_Clock, depth=32):
    """  Ram model """
    
    mem = [Signal(intbv(0)[8:]) for i in range(depth)]
    
    @always(i_Clock.posedge)
    def write():
        if we:
            mem[addr].next = din
                
    @always_comb
    def read():
        dout.next = mem[addr]

    return write, read
    
def sdram_test_tb():
    clk, sdram_clk, sdram_return_clk, i_uart_rx,o_uart_tx = [Signal(bool(0)) for _ in range(5)]
    w_RX_DV, o_TX_Done, w_TX_Active,w_TX_Serial = [Signal(bool(0)) for _ in range(4)]
    w_RX_Byte = Signal(intbv(0)[8:])
    state_tx = Signal(t_state_tx.TX_IDLE)
    state_rx = Signal(t_state_rx.RX_IDLE)
    dout = Signal(intbv(0)[16:])
    dout_v = Signal(intbv(0)[15:])
    din = Signal(intbv(0)[15:])
    addr = Signal(intbv(0)[7:])
    we = Signal(bool(0))
    ram_inst = ram(dout, din, addr, we, i_Clk, depth=32)
    @always_comb
    def sdram_clk_loopback():
        sdram_return_clk.next = sdram_clk

    #drvrs = [TristateSignal(bool(0)) for _ in range(8)]
    led_status = Signal(intbv(0,0,16))
    pb = Signal(bool(1))
    sd_intf_inst = sd_intf()
    sdram_inst = sdram(sdram_clk, sd_intf_inst, show_command=False)
    dut = sdram_test(clk, sdram_clk, sdram_return_clk, led_status, i_uart_rx, o_uart_tx, pb, sd_intf_inst)

    @instance
    def clk_gen():
        yield delay(140)
        for _ in range(10000):
            clk.next = not clk
            yield delay(1)
        pb.next = 0
        for _ in range(100):
            clk.next = not clk
            yield delay(1)
        pb.next = 1
        for _ in range(6000):
            clk.next = not clk
            yield delay(1)
        raise StopSimulation

    return instances()


if __name__ == '__main__':
    #Simulation(traceSignals(sdram_test_tb)).run()

    clk, sdram_clk, sdram_return_clk = [Signal(bool(0)) for _ in range(3)]
 
    led_status = Signal(intbv(0,0,16))
    pb = Signal(bool(1))
    i_uart_rx = Signal(bool(0))
    o_uart_tx = Signal(bool(0))
    sd_intf_inst = sd_intf()
    toVerilog(sdram_test, clk, sdram_clk, sdram_return_clk, led_status, i_uart_rx, o_uart_tx, pb, sd_intf_inst)
