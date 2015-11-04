set terminal latex
unset key
set logscale y 10
set xlabel "Files of GCC 6.0"
set ylabel "Speedup"
set output "speedup.tex"
set datafile separator ","
plot "speedup.txt" with impulses
