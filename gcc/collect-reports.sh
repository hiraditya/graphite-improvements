#!/bin/bash

ninsns () {
    echo $(callgrind_annotate --inclusive=yes --threshold=100 $1 | grep "$2" | sed -e 's/^ *//g' | cut -d ' ' -f 1 | sed -e 's/,//g' | sed -e ':a;N;$!ba;s/\n/ + /g' | bc)
}

collect () {
    fn="$1"
    mv $dir $dir-$(date +%s)
    mkdir -p $dir
    for f in $(ls -1 *.ii); do
	echo $f
	out=$dir/`basename $f`.callgrind.out
        valgrind --dsymutil=yes --tool=callgrind --dump-instr=yes --callgrind-out-file=$out $CC $CFLAGS $f
	echo -n "$f: " | tee -a $dir/report.txt
        ninsns $out "$fn(" | tee -a $dir/report.txt
        rm -f $out
    done
}

export LD_LIBRARY_PATH=/home/adityak/work/install/lib:$LD_LIBRARY_PATH

old () {
    CC=/home/adityak/work/gcc/install-old-scop/bin/../libexec/gcc/x86_64-pc-linux-gnu/6.0.0/cc1plus
    CFLAGS="-Ofast -fgraphite-identity"
    dir=old
    collect build_scops
}

new () {
    CC=/home/adityak/work/gcc/install-new-scop/bin/../libexec/gcc/x86_64-pc-linux-gnu/6.0.0/cc1plus
    CFLAGS="-Ofast -fgraphite-identity"
    dir=new
    collect build_scop_depth
}

old &
new &

