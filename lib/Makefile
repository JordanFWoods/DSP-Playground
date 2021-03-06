################################################
## Proprietary Property of:
##
## Jordan Woods
## 312 Calle Bonita
## Escondido CA, 92029
##
################################################
## Title: Makefile for DSP-Playground
##
## File Name: Makefile
##
## Author: jordan
##
## Description: This is the Makefile associated
##              with the DSP-Playground repo. It
##              currently compiles the repo and
##              can run individual scenarios.
##
################################################
## Manual Revision History:
## 12/16/20 - JFW - Initial Check In.
## 02/23/21 - JFW - Fixed vsim cfg bug.
##
######## Libraries / Variable Lists #########

# Relative path assignments.
# ALL Path assignments need to begin with a constant
# if the Makefile moves, only sandbox needs to change
sandbox        = ../../..
OSVVM          = $(sandbox)/OSVVM
JordanFWoods   = $(sandbox)/JordanFWoods
DSP-Playground = $(JordanFWoods)/DSP-Playground
imp            = $(DSP-Playground)/imp
lib            = $(DSP-Playground)/lib
sim            = $(DSP-Playground)/sim
src            = $(DSP-Playground)/src

# VCOM OPTIONS
VCOM_OPT = -2008 -quiet
# VSIM OPTIONS
VSIM_OPT = -voptargs="+acc" "+nowarn8683"

# libraries and results directory for compile
LIBRARIES = \
	$(lib)/sim_lib/makeobj.txt \
	$(lib)/synth_lib/makeobj.txt

# results directory for first compile
RESULTS_DIR = \
	$(lib)/results/makeobj.txt

# Libraries re-listed for make clean (removal)
rm_libs = $(addsuffix .rm, $(LIBRARIES))

# List of scenarios names
SCENARIOS = \
	discretes \
	template

# generate list of scenario logfiles that we wish to "compile"
log_files    = $(patsubst %,$(lib)/results/%.log,$(SCENARIOS))
# generate list of scenario compiled objects.
SCENARIO_DAT = $(patsubst %,$(lib)/sim_lib/tcb/%.dat,$(SCENARIOS))

############# Other Makefiles / Library Constants #######

# OSVVM
OSVVM_LIB_NAME = osvvm
OSVVM_OBJ_DIR  = $(lib)/$(OSVVM_LIB_NAME)
OSVVM_SRC_DIR  = $(OSVVM)
OSVVM_MKFL_DIR = $(sim)/sim_pkgs
OSVVM_VCOM_OPT = $(VCOM_OPT) -work $(OSVVM_LIB_NAME)

# CLK_RST_BFM
CLK_LIB_NAME   = clk_bfm_lib
CLK_RST_OBJ    = $(lib)/$(CLK_LIB_NAME)
CLK_RST_SRC    = $(sim)/bfm/clk_rst_bfm
CLK_VCOM_OPT   = $(VCOM_OPT) -work $(CLK_LIB_NAME)

# Disc BFM
DISC_LIB_NAME  = disc_bfm_lib
DISC_BFM_OBJ   = $(lib)/$(DISC_LIB_NAME)
DISC_BFM_SRC   = $(sim)/bfm/disc_bfm
DISC_VCOM_OPT  = $(VCOM_OPT) -work $(DISC_LIB_NAME)

# All Generated Libraries to delete by a make clean
RM_LIBS        = $(rm_libs) $(OSVVM_LIB) $(CLK_RST_RM_LIB) $(DISC_BFM_RM_LIB)

######### Normal Compile ###########
# just run 'make'

# Overall Top Level Testbench
$(lib)/sim_lib/testbench/_primary.dat : \
	$(sim)/tb_src/testbench.vhd \
	$(LIBRARIES) \
	$(lib)/sim_lib/tcb/_primary.dat \
	$(lib)/sim_lib/bfm_harness/_primary.dat \
	$(lib)/synth_lib/top_pl/_primary.dat \
	$(lib)/sim_lib/tb_pkg/_primary.dat \
	$(CLK_RST_OBJ)/clk_rst_bfm/_primary.dat \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat \
	$(DISC_BFM_OBJ)/bfm_pkg/_primary.dat
	vcom $(VCOM_OPT) -work sim_lib $<

# Design Code

# synthesis package
$(lib)/synth_lib/synth_pkg/_primary.dat : \
	$(src)/synth_pkg.vhd
	vcom $(VCOM_OPT) -work synth_lib $<

# top_pl
$(lib)/synth_lib/top_pl/_primary.dat  : \
	$(src)/top_pl.vhd \
	$(lib)/synth_lib/synth_pkg/_primary.dat
	vcom $(VCOM_OPT) -work synth_lib $<

# Testbench Submodules

# TCB
$(lib)/sim_lib/tcb/_primary.dat : \
	$(sim)/tb_src/tcb_e.vhd \
	$(lib)/sim_lib/tb_pkg/_primary.dat \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat \
	$(lib)/sim_lib/gen_prot/_primary.dat \
	$(DISC_BFM_OBJ)/disc_bfm/_primary.dat
	vcom $(VCOM_OPT) -work sim_lib $<

# General Proctected Package File
$(lib)/sim_lib/gen_prot/_primary.dat : \
	$(sim)/sim_pkgs/gen_prot.vhd
	vcom $(VCOM_OPT) -work sim_lib $<

# General Resolution Package File
$(lib)/sim_lib/gen_res/_primary.dat : \
	$(sim)/sim_pkgs/gen_res.vhd
	vcom $(VCOM_OPT) -work sim_lib $<

# tb_pkg
$(lib)/sim_lib/tb_pkg/_primary.dat : \
	$(sim)/tb_src/tb_pkg.vhd \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat
	vcom $(VCOM_OPT) -work sim_lib $<

# BFM Harness
$(lib)/sim_lib/bfm_harness/_primary.dat : \
	$(sim)/tb_src/bfm_harness.vhd \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat \
	$(CLK_RST_OBJ)/clk_rst_bfm/_primary.dat \
	$(DISC_BFM_OBJ)/bfm_pkg/_primary.dat \
	$(DISC_BFM_OBJ)/disc_bfm/_primary.dat
	vcom $(VCOM_OPT) -work sim_lib $<

####### Other MakeFiles ######

-include $(OSVVM_MKFL_DIR)/Makefile.osvvm
-include $(CLK_RST_SRC)/Makefile
-include $(DISC_BFM_SRC)/Makefile

######## Make Libraries #######

# Make the library directories, if needed.
$(LIBRARIES) :
	vlib -type directory $(dir $@)
	@echo "This file was written and is managed by the Makefile. Do not alter / Delete" > $@
	vmap -quiet $(patsubst $(lib)/%/, %, $(dir $@)) $(dir $@)

# make the results directory.
$(RESULTS_DIR) : $(LIBRARIES)
	mkdir -p $(dir $@)
	@echo "This file was written and is managed by the Makefile. Do not alter / Delete" > $@

##### Make Clean #######

# Remove all libraries
$(rm_libs) : %.rm :
	rm -rf $(dir $@)

# If 'make clean' is called, remove all libraries
.PHONY: clean
clean : $(RM_LIBS)

######## Scenarios ######

# Compile the TCB Architecture.
$(SCENARIO_DAT) : $(lib)/sim_lib/tcb/%.dat : $(sim)/scen/%.vhd \
	$(lib)/sim_lib/tcb/_primary.dat
	vcom $(VCOM_OPT) -work sim_lib $<

# To "compile a logfile", run vsim, and ensure that the tcb architecture is compiled.
$(log_files) : $(lib)/results/%.log : $(lib)/sim_lib/tcb/%.dat \
	$(lib)/sim_lib/testbench/_primary.dat \
	$(RESULTS_DIR)
	vsim sim_lib.$*_cfg $(VSIM_OPT) \
	-do $(sim)/scen/sim.do -wlf $(lib)/results/$*.wlf -l $(lib)/results/$*.log

# if a scenario in the list is called "compile a logfile" i.e. run vsim.
$(SCENARIOS) : % : $(lib)/results/%.log \
	$(lib)/sim_lib/testbench/_primary.dat \
	$(lib)/sim_lib/tcb/%.dat

# # NOTE THESE ARE CURRENTLY UNUSED
# # generate list of optimization objects for scenario running.
# opt_objs     = $(patsubst %,./sim_lib/%_o/_deps,$(SCENARIOS))
# # I still don't understand what ucdb files are for...
# ucdb_files   = $(patsubst %,./results/%.ucdb,$(SCENARIOS))
# # location of all scenario optimizations
# OPT_LIBS     = $(patsubst %,./sim_lib/%_o/makeobj.txt,$(SCENARIOS))

## To add later if optimizations to the simulations are desired.
#  $(opt_objs) : ./sim_lib/%_o/_deps : ./sim_lib/tcb/%.dat $(ALL_OBJS)
#  	vopt +acc=npr -quiet -work sim_lib $* -o $*_o
