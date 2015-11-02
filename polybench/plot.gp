set terminal latex
unset key
set xlabel "Polybench"
set ylabel "speedup"
set output "speedup.tex"
set datafile separator ","
plot "speedup.txt" with impulses
