# Overall Testbench
testbench: ../sim/tb_src/testbench.vhd tcb.o bfm_harness.o top_pl.o
	vcom -2008 ../sim/tb_src/testbench.vhd

# BFM Harness Files
clk_rst_bfm.o: ../sim/bfm/clk_rst_bfm/clk_rst_bfm.vhd
	vcom -2008 ../sim/bfm/clk_rst_bfm/clk_rst_bfm.vhd
disc_bfm.o:
	vcom -2008 ../sim/bfm/disc_bfm/bfm_pkg.vhd
	vcom -2008 ../sim/bfm/disc_bfm/disc_bfm.vhd
bfm_harness.o: ../sim/tb_src/bfm_harness.vhd clk_rst_bfm.o disc_bfm.o
	vcom -2008 ../sim/tb_src/bfm_harness.vhd

# DUT / SOURCE Files
synth_pkg.o: ../src/synth_pkg.vhd
	vcom -2008 ../src/synth_pkg.vhd
top_pl.o: ../src/top_pl.vhd synth_pkg.o
	vcom -2008 ../src/top_pl.vhd

# TCB Entity
tcb.o: ../sim/tb_src/tcb_e.vhd
	vcom -2008 ../sim/tb_src/tcb_e.vhd

