//python sdram_test.py to create sdram_test.v
//verilator --trace -Wall --cc sdram_test.v --exe sim_main.cpp
//make -j -C obj_dir -f Vsdram_test.mk Vsdram_test
//./obj_dir/Vsdram_test
/*
tfp 0x15ee2f0 
testing sdram_test
- sdram_test.v:512: Verilog $finish
* 
* 
* -rw-r--r-- 1 pi pi      0 Jul 24 03:06 sdram_test.vcd
* 
*/
/* Need to append before the endmodule
initial 
begin $display("testing sdram_test"); $finish ; 
end
*/ 
//trying to get a vcd file following example pg 66 
#include "Vsdram_test.h"
#include "verilated.h"

#include "verilated_vcd_c.h"


FILE * tfp;
int main_time;
int main(int argc, char** argv, char** env) {
	Verilated::commandArgs(argc,argv);
	Verilated::traceEverOn(true);
	
	Vsdram_test* top = new Vsdram_test;
	tfp =  fopen("obj_dir/sdram_test.vcd","w");
	printf("tfp 0x%x \n",tfp);
	 
	 
	while (!Verilated::gotFinish()) { 
		top->eval(); 
		main_time += 1;
		//tfp->dump (main_time);
		}
	delete top;
	
	//tfp->close();
	exit(0);
}
