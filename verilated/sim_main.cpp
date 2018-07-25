// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2017 by Wilson Snyder.
//======================================================================

// Include common routines
#include <verilated.h>

#include <sys/stat.h>  // mkdir

// Include model header, generated from Verilating "sdram_test.v"
#include "Vsdram_test.h"

// If "verilator --trace" is used, include the tracing class
#if VM_TRACE
# include <verilated_vcd_c.h>
#endif

// Current simulation time (64-bit unsigned)
vluint64_t main_time = 0;
// Called by $time in Verilog
double sc_time_stamp () {
    return main_time; // Note does conversion to real, to match SystemC
}

int main(int argc, char** argv, char** env) {
    // This is a more complicated example, please also see the simpler examples/hello_world_c.

    // Prevent unused variable warnings
    if (0 && argc && argv && env) {}
    // Pass arguments so Verilated code can see them, e.g. $value$plusargs
    Verilated::commandArgs(argc, argv);

    // Set debug level, 0 is off, 9 is highest presently used
    Verilated::debug(0);

    // Randomization reset policy
    Verilated::randReset(2);

    // Construct the Verilated model, from Vsdram_test.h generated from Verilating "sdram_test.v"
    Vsdram_test* sdram_test = new Vsdram_test; // Or use a const unique_ptr, or the VL_UNIQUE_PTR wrapper

#if VM_TRACE
    // If verilator was invoked with --trace argument,
    // and if at run time passed the +trace argument, turn on tracing
    VerilatedVcdC* tfp = NULL;
    const char* flag = Verilated::commandArgsPlusMatch("trace");
    if (flag && 0==strcmp(flag, "+trace")) {
        Verilated::traceEverOn(true);  // Verilator must compute traced signals
        VL_PRINTF("Enabling waves into logs/vlt_dump.vcd...\n");
        tfp = new VerilatedVcdC;
        sdram_test->trace(tfp, 99);  // Trace 99 levels of hierarchy
        mkdir("logs", 0777);
        tfp->open("logs/vlt_dump.vcd");  // Open the dump file
    }
#endif

    // Set some inputs
     
    sdram_test->master_clk_i = 0;
     

    // Simulate until $finish
    while (!Verilated::gotFinish()) {
        main_time++;  // Time passes...

        // Toggle clocks and such
        sdram_test->master_clk_i = !sdram_test->master_clk_i;
        if ((main_time % 10) == 3) {
            sdram_test->master_clk_i = 1;
        }
  

        // Evaluate model
        sdram_test->eval();

#if VM_TRACE
        // Dump trace data for this cycle
        if (tfp) tfp->dump (main_time);
#endif

        // Read outputs
         
    }

    // Final model cleanup
    sdram_test->final();

    // Close trace if opened
#if VM_TRACE
    if (tfp) { tfp->close(); tfp = NULL; }
#endif

    //  Coverage analysis (since test passed)
#if VM_COVERAGE
    mkdir("logs", 0777);
    VerilatedCov::write("logs/coverage.dat");
#endif

    // Destroy model
    delete sdram_test; sdram_test = NULL;

    // Fin
    exit(0);
}
