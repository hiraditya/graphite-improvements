set terminal latex
unset key
set xlabel "Files of GCC"
set ylabel "Speedup"
set output "speedup.tex"
set datafile separator ","
plot "speedup.txt" with impulses
