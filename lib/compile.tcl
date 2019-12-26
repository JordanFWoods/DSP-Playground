puts {
  ModelSimSE general compile script version 1.1
  Copyright (c) Doulos June 2004, SD
}

# Simply change the project settings in this section
# for each new project. There should be no need to
# modify the rest of the script.

cd ../
set PROJ [pwd]
set SRC   $PROJ/src
set SIM   $PROJ/sim
set LIB   $PROJ/lib
set OSV   c:/Users/jorda/sandbox/OSVVM
cd $LIB
echo $SRC

set library_file_list {
   osvvm     { 
       c:/Users/jorda/sandbox/OSVVM/NamePkg.vhd
       c:/Users/jorda/sandbox/OSVVM/OsvvmGlobalPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/VendorCovApiPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/TranscriptPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/TextUtilPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/AlertLogPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/MessagePkg.vhd
       c:/Users/jorda/sandbox/OSVVM/SortListPkg_int.vhd
       c:/Users/jorda/sandbox/OSVVM/RandomBasePkg.vhd
       c:/Users/jorda/sandbox/OSVVM/RandomPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/CoveragePkg.vhd
       c:/Users/jorda/sandbox/OSVVM/MemoryPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/ScoreboardGenericPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/ScoreboardPkg_slv.vhd
       c:/Users/jorda/sandbox/OSVVM/ScoreboardPkg_int.vhd
       c:/Users/jorda/sandbox/OSVVM/ResolutionPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/TbUtilPkg.vhd
       c:/Users/jorda/sandbox/OSVVM/OsvvmContext.vhd}
   synth_lib { 
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/src/synth_pkg.vhd
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/src/top_pl.vhd}
   clk_bfm_lib   {
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/sim/bfm/clk_rst_bfm/clk_rst_bfm.vhd}
   gen_bfm_lib   {
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/sim/bfm/gen_bfm/bfm_pkg.vhd
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/sim/bfm/gen_bfm/gen_bfm.vhd}
   sim_lib       {
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/sim/tb_src/tb_pkg.vhd
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/sim/tb_src/bfm_harness.vhd
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/sim/tb_src/tcb_e.vhd
       C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/sim/tb_src/testbench.vhd}
}
set top_level              sim_lib.testbench
set wave_patterns {
                           /*
}
set wave_radices {
                           hexadecimal {data q}
}


# After sourcing the script from ModelSim for the
# first time use these commands to recompile.

proc r  {} {uplevel #0 source compile.tcl}
proc rr {} {global last_compile_time
            set last_compile_time 0
            r                            }
proc q  {} {quit -force                  }

#Does this installation support Tk?
set tk_ok 1
if [catch {package require Tk}] {set tk_ok 0}

# Prefer a fixed point font for the transcript
set PrefMain(font) {Courier 10 roman normal}

# Compile out of date files
set time_now [clock seconds]
if [catch {set last_compile_time}] {
  set last_compile_time 0
}
foreach {library file_list} $library_file_list {
  vlib $library
  vmap work $library
  foreach file $file_list {
    if { $last_compile_time < [file mtime $file] } {
      if [regexp {.vhdl?$} $file] {
        vcom -2008 $file
      } else {
        vlog $file
      }
      set last_compile_time 0
    }
  }
}
set last_compile_time $time_now

# Load the simulation
vcom -reportprogress 300 -2008 -work sim_lib $SIM/scen/template/tcb_template.vhd
file mkdir  ./results/
# file attributes C:/Users/jorda/sandbox/JordanFWoods/DSP-Playground/lib/results/ -owner system
eval vsim $top_level -displaymsgmode both -voptargs=+acc +nowarn8683 \
    -wlf ./results/template.wlf \
    -l   ./results/template.log \
    sim_lib.tcb_template -GG_SCENARIO=template

# If waves are required
if [llength $wave_patterns] {
  noview wave
  foreach pattern $wave_patterns {
    add wave $pattern
  }
  configure wave -signalnamewidth 1
  foreach {radix signals} $wave_radices {
    foreach signal $signals {
      catch {property wave -radix $radix $signal}
    }
  }
}

# Run the simulation
onbreak {resume}
log -r /*
coverage save -onexit ./results/loopback.ucdb
set IgnoreWarning 1
run 1
set IgnoreWarning 0
run -all
simstats

# If waves are required
if [llength $wave_patterns] {
  if $tk_ok {wave zoomfull}
}

quit

puts {
  Script commands are:

  r = Recompile changed and dependent files
 rr = Recompile everything
  q = Quit without confirmation
}

# How long since project began?
if {[file isfile start_time.txt] == 0} {
  set f [open start_time.txt w]
  puts $f "Start time was [clock seconds]"
  close $f
} else {
  set f [open start_time.txt r]
  set line [gets $f]
  close $f
  regexp {\d+} $line start_time
  set total_time [expr ([clock seconds]-$start_time)/60]
  puts "Project time is $total_time minutes"
}