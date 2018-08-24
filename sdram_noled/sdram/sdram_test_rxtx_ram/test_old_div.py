from __future__ import division
from __future__ import print_function
from __future__ import absolute_import
from future import standard_library
standard_library.install_aliases()
from builtins import object
from past.utils import old_div

from myhdl import *
from SDRAM_Controller.sd_intf import sd_intf
from math import ceil
#FREQ_GHZ_G       = old_div(sd_intf.SDRAM_FREQ_C, 1000)
FREQ_GHZ_G       = old_div(sd_intf.SDRAM_FREQ_C, 1000)
print ("w/ old_div",FREQ_GHZ_G)

FREQ_GHZ_G       = (sd_intf.SDRAM_FREQ_C / 1000)
print ("w/ /",FREQ_GHZ_G)

#REF_CYCLES_C = int(old_div(sd_intf.timing['ref'], sd_intf.SDRAM_FREQ_C)  )


REF_CYCLES_C = int(old_div(sd_intf.timing['ref'], sd_intf.SDRAM_FREQ_C)  )
print ("w/ old_div",REF_CYCLES_C)


REF_CYCLES_C = int(old_div(sd_intf.timing['ref'], sd_intf.SDRAM_FREQ_C)  )
print ("w/ /",REF_CYCLES_C)

