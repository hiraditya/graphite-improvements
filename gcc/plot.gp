set terminal latex
set key top left
#set logscale y 2
set xlabel "Files of GCC 6.0"
set ylabel "\\rotatebox{90}{\\% of overall compilation time}"
set output "speedup.tex"
set datafile separator ","
plot "old-speedup.txt" with points pointtype 1 title "old SCoP detection", "new-speedup.txt" with points pointtype 7 title "new SCoP detection"
