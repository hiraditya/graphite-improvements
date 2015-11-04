#!/bin/bash

collect () {
    > speedup.txt
    for i in $(grep -vre ': $' new/report.txt | cut -d ':' -f 1); do
        old=$(grep "^$i" old/report.txt | cut -d ':' -f 2)
        new=$(grep "^$i" new/report.txt | cut -d ':' -f 2)
        speedup=$(echo "scale=2; ($old / $new)" | bc)
        echo $(echo $i | sed -e 's/callgrind.out.//g'), $speedup &>> speedup.txt
    done
    sort -k2 -n speedup.txt > speedup-sorted.txt
    cat speedup-sorted.txt | cut -d ',' -f 2 > speedup.txt
}

collect
gnuplot plot.gp

