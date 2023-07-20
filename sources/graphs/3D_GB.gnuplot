set terminal epslatex size 5,4
set output "graphs/3D_GB.tex"

set grid
set title ""
#set key at -1500,2000
unset key
set size ratio -1
set view equal xyz
set xlabel "$x$ [mm]"
set ylabel "$y$ [mm]"
set zlabel "$z$ [mm]"
set format x "%.f"
set format y "%.f"
set format z "%.f"
set view 60,20
set xyplane 0
set lmargin at screen 0.25
set rmargin at screen 0.8
set bmargin at screen 0
set tmargin at screen 1

splot[][][] "data/3D_GB.dat" index 0 using 1:2:3 title "Feasible poses" with points linecolor "green" pointsize 0.4 pointtype 7,\
            "data/3D_GB.dat" index 1 using 1:2:3 title "Infeasible poses" with points linecolor "blue" pointsize 0.4 pointtype 7,\
            "data/3D_GB.dat" index 2 using 1:2:3 title "Poses failed to compute" with points linecolor "red" pointsize 0.4 pointtype 7
