set terminal latex
unset key
set xlabel "Files of Polybench"
set ylabel "\\rotatebox{90}{SCoP Detection Speedup}"
set output "speedup.tex"
set yrange [0:2.5]
set datafile separator ","
set arrow from 0,1 to 30,1 nohead
plot "speedup.txt" with impulses
