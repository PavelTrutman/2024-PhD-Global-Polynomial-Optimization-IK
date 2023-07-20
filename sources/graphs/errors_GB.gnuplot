set terminal epslatex size 6,4
set output "graphs/errors_GB.tex"

set grid
set key tmargin
set title ""
set xlabel "Pose error"
set ylabel "Frequency"
#set format y "\\num{%.0f}"
set samples 100000

logbase = 10
set logscale x logbase
set format x sprintf("$%d^{%%L}$", logbase)
set logscale y logbase
set format y sprintf("$%d^{%%L}$", logbase)

# histogram
Min = 1e-6
Max = 1e0
n = 100.0
datafiles = 1.0
width = (log(Max)/log(logbase)-log(Min)/log(logbase))/n
boxwidth = 1.0/datafiles
bin(x) = width*(floor((log(x)/log(logbase)-log(Min)/log(logbase))/width)+0.5) + log(Min)/log(logbase)
offset(x, y) = logbase**(bin(x)+(y-datafiles/2.0-0.5)*boxwidth)

set boxwidth boxwidth relative

set xrange [Min:Max]
plot "data/errorsT_GB.dat" using (offset($1,1)):(1.0) title "Translation error [mm]" smooth freq with steps lw 4 lc "blue",\
     "data/errorsR_GB.dat" using (offset($1,1)):(1.0) title "Rotation error [deg]" smooth freq with steps lw 4 lc "red",\
