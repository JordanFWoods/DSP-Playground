LIBRARIES = \
	./sim_lib/makeobj.txt \
	./synth_lib/makeobj.txt \
	./clk_bfm_lib/makeobj.txt \
	./disc_bfm_lib/makeobj.txt

RESULTS_DIR = \
	../sim/results/makeobj.txt

# Overall Testbench - sim_lib library
./sim_lib/testbench/_primary.dat : \
	../sim/tb_src/testbench.vhd \
	$(LIBRARIES) \
	./sim_lib/tcb/_primary.dat \
	./sim_lib/bfm_harness/_primary.dat \
	./synth_lib/top_pl/_primary.dat \
	./sim_lib/tb_pkg/_primary.dat \
	./clk_bfm_lib/clk_rst_bfm/_primary.dat \
	./disc_bfm_lib/bfm_pkg/_primary.dat
	vcom -2008 -quiet -work sim_lib $<

$(LIBRARIES) :
	vlib -type directory $(dir $@)
	@echo "This file was written and is managed by the Makefile. Do not alter / Delete" > $@

$(RESULTS_DIR) : $(LIBRARIES)
	mkdir -p $(dir $@)

# DUT / SOURCE Files
./synth_lib/synth_pkg/_primary.dat : \
	../src/synth_pkg.vhd
	vcom -2008 -quiet -work synth_lib $<

./synth_lib/top_pl/_primary.dat  : \
	../src/top_pl.vhd \
	./synth_lib/synth_pkg/_primary.dat
	vcom -2008 -quiet -work synth_lib $<

./sim_lib/tcb/_primary.dat : \
	../sim/tb_src/tcb_e.vhd \
	./sim_lib/tb_pkg/_primary.dat \
	./sim_lib/gen_prot/_primary.dat \
	./disc_bfm_lib/disc_bfm/_primary.dat
	vcom -2008 -quiet -work sim_lib $<

./sim_lib/gen_prot/_primary.dat : \
	../sim/sim_pkgs/gen_prot.vhd
	vcom -2008 -quiet -work sim_lib $<

./sim_lib/gen_res/_primary.dat : \
	../sim/sim_pkgs/gen_res.vhd
	vcom -2008 -quiet -work sim_lib $<

./sim_lib/tb_pkg/_primary.dat : \
	../sim/tb_src/tb_pkg.vhd
	vcom -2008 -quiet -work sim_lib $<

./sim_lib/bfm_harness/_primary.dat : \
	../sim/tb_src/bfm_harness.vhd \
	./clk_bfm_lib/clk_rst_bfm/_primary.dat \
	./disc_bfm_lib/bfm_pkg/_primary.dat
	vcom -2008 -quiet -work sim_lib $<

# BFM Harness Files - clk_rst_lib library
./clk_bfm_lib/clk_rst_bfm/_primary.dat : \
	../sim/bfm/clk_rst_bfm/clk_rst_bfm.vhd
	vcom -2008 -quiet -work clk_bfm_lib $<

# BFM Harness Files - disc_bfm_lib library
./disc_bfm_lib/bfm_pkg/_primary.dat : \
	../sim/bfm/disc_bfm/bfm_pkg.vhd
	vcom -2008 -quiet -work disc_bfm_lib $<

./disc_bfm_lib/disc_bfm/_primary.dat : \
	../sim/bfm/disc_bfm/disc_bfm.vhd \
	./disc_bfm_lib/bfm_pkg/_primary.dat
	vcom -2008 -quiet -work disc_bfm_lib $<
