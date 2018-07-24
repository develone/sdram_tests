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
//These headers were taken from promach cordic code

//none of the fix the not compile
//It appears the one that created the fix was
//Instantiation of module as uut
//#include <iostream>
//#include <string>
//#include <cstdlib>
//#include <cstdio>
//#include <bitset>
//#include <limits>
//#include <iomanip>
//#include <typeinfo>
Vsdram_test *uut;                     // Instantiation of module
 
vluint64_t main_time;
int main(int argc, char** argv, char** env) {
	// turn on trace or not?
    //bool vcdTrace = false;
    VerilatedVcdC* tfp = new VerilatedVcdC;
    
	Verilated::commandArgs(argc,argv);
	Verilated::traceEverOn(true);
	uut = new Vsdram_test;   // Create instance
	//file is now being opened 
	tfp->open("obj_dir/sdram_test.vcd");
	printf("tfp 0x%x \n",tfp);
	 
	 
	while (!Verilated::gotFinish()) { 
		uut->eval(); 
		main_time += 6000;
		printf("tfp 0x%llx \n",main_time);
		tfp->dump (main_time);
		}
	delete uut;
	
	tfp->close();
	exit(0);
}
