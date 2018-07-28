from myhdl import *
from SDRAM_Controller.SdramCntl import *
from SDRAM_Controller.host_intf import *
from SDRAM_Controller.sd_intf import *

if __name__ == '__main__':
     
    clk = Signal(bool(0))  
 
    
    sd_intf_inst = sd_intf()
    host_intf_inst = host_intf()
    toVerilog(MySdramCntl,clk, host_intf_inst , sd_intf_inst)
