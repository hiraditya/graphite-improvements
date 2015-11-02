set terminal latex
unset key
set xlabel "GCC"
set ylabel "speedup"
set output "speedup.tex"
set datafile separator ","
plot "speedup.txt" with impulses
