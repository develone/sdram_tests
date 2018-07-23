//python sdram_test.py to create sdram_test.v
//verilator -Wall --cc sdram_test.v --exe sim_main.cpp
//make -j -C obj_dir -f Vsdram_test.mk Vsdram_test
//./obj_dir/Vsdram_test
/* Need to append before the endmodule
initial 
begin $display("testing sdram_test"); $finish ; 
end
*/ 
#include "Vsdram_test.h"
#include "verilated.h"
int main(int argc, char** argv, char** env) {
	Verilated::commandArgs(argc,argv);
	Vsdram_test* top = new Vsdram_test;
	while (!Verilated::gotFinish()) { top->eval(); }
	delete top;
	exit(0);
}
