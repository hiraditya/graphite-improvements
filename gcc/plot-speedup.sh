#!/bin/bash

sortit() {
    sort -k2 -n $1 > sorted-$1
    cat sorted-$1 | cut -d ',' -f 2 > $1
}

collect () {
    > speedup.txt
    > old-speedup.txt
    > new-speedup.txt
    for i in $(grep -vre ': $' new/report.txt | cut -d ':' -f 1); do
        old=$(grep "^$i" old/report.txt | cut -d ':' -f 2)
        new=$(grep "^$i" new/report.txt | cut -d ':' -f 2)
        main=$(grep "^$i" old/main.txt | cut -d ':' -f 2)
        pold=$(echo "scale=4; ($old / $main) * 100" | bc)
        pnew=$(echo "scale=4; ($new / $main) * 100" | bc)
        diff=$(echo "scale=4; $pold - $pnew" | bc)
        #speedup=$(echo "scale=2; ($old / $new)" | bc)
        #echo $(echo $i | sed -e 's/callgrind.out.//g'), $speedup &>> speedup.txt
        echo $(echo $i | sed -e 's/callgrind.out.//g'), $pold &>> old-speedup.txt
        echo $(echo $i | sed -e 's/callgrind.out.//g'), $pnew &>> new-speedup.txt
    done
    #sortit speedup.txt
    sortit old-speedup.txt
    sortit new-speedup.txt
}

#collect
gnuplot plot.gp

