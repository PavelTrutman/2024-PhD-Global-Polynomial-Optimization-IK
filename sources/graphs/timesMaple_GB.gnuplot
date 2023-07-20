set terminal epslatex size 3,3
set output "graphs/timesMaple_GB.tex"

set grid
set key top right
set key samplen 0.5
#unset key
set title ""
set xlabel "Maple execution time [s]"
#set ylabel "Frequency"
set samples 100000

logbase = 10
set logscale y logbase
#set format y sprintf("$%d^{%%L}$", logbase)
set format y ""

set lmargin 0.1

# histogram
Min = 1.5
Max = 3
n = 20.0
datafiles = 3.0
width = (Max-Min)/n
boxwidth = width*1.0/datafiles
bin(x) = width*(floor((x-Min)/width)+0.5) + Min
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

set xrange [Min:Max]
set yrange [1:1e5]
plot "data/timesMaple_GB.dat" index 0 using (offset($1,1)):(1.0) title "Feasible poses" smooth freq with boxes fill solid noborder lc "green",\
                  "data/timesMaple_GB.dat" index 1 using (offset($1,2)):(1.0) title "Infeasible poses" smooth freq with boxes fill solid noborder lc "blue",\
                  "data/timesMaple_GB.dat" index 2 using (offset($1,3)):(1.0) title "Poses failed to compute" smooth freq with boxes fill solid noborder lc "red"
