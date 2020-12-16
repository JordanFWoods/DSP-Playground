onbreak {resume}
log -r /*
# coverage save -onexit ./results/loopback.ucdb
set IgnoreWarning 1
run 1
set IgnoreWarning 0
run -all
simstats
quit