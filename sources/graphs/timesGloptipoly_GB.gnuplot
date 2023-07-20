set terminal epslatex size 3.5,3
set output "graphs/timesGloptipoly_GB.tex"

set grid
#set key tmargin right
unset key
set xlabel "GloptiPoly execution time [s]"
set ylabel "Frequency"
set samples 100000
#set key maxrows 1
#set key samplen 0.5

set rmargin 0.1

logbase = 10
set logscale y logbase
set format y sprintf("$%d^{%%L}$", logbase)

# histogram
Min = 2
Max = 12
n = 20.0
datafiles = 3.0
width = (Max-Min)/n
boxwidth = width*1.0/datafiles
bin(x) = width*(floor((x-Min)/width)+0.5) + Min
offset(x, y) = bin(x)+(y-datafiles/2.0-0.5)*boxwidth

set boxwidth boxwidth absolute

set xrange [Min:Max]
set yrange [1:1e5]
plot "data/timesGloptipoly_GB.dat" index 0 using (offset($1,1)):(1.0) title "Feasible" smooth freq with boxes fill solid noborder lc "green",\
                  "data/timesGloptipoly_GB.dat" index 1 using (offset($1,2)):(1.0) title "Infeasible" smooth freq with boxes fill solid noborder lc "blue",\
                  "data/timesGloptipoly_GB.dat" index 2 using (offset($1,3)):(1.0) title "Failed to compute" smooth freq with boxes fill solid noborder lc "red"
