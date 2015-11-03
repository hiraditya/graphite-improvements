#!/bin/bash

collect () {
    mv $dir $dir-$(date +%s)
    mkdir -p $dir
    for f in $(ls -1 *.i); do
	echo $f
	pref=`basename $f`
        valgrind --dsymutil=yes --tool=callgrind --dump-instr=yes --callgrind-out-file=$dir/callgrind.out.$pref $CC $CFLAGS $f
    done
}

ninsns () {
    echo $(callgrind_annotate --inclusive=yes --threshold=100 $1 | grep "$2" | sed -e 's/^ *//g' | cut -d ' ' -f 1 | sed -e 's/,//g' | sed -e ':a;N;$!ba;s/\n/ + /g' | bc)
}

report () {
    fn=$1
    cd $dir
    for f in $(ls -1 callgrind.out.*); do
	echo -n "$f: "
        ninsns $f "$fn("
    done
}

export LD_LIBRARY_PATH=/home/adityak/work/install/lib:$LD_LIBRARY_PATH

CC=/home/adityak/work/gcc/install-old-scop/bin/../libexec/gcc/x86_64-pc-linux-gnu/6.0.0/cc1
CFLAGS="-Ofast -fgraphite-identity"
dir=old
collect
report build_scops | tee $dir/report.txt

CC=/home/adityak/work/gcc/install-new-scop/bin/../libexec/gcc/x86_64-pc-linux-gnu/6.0.0/cc1
CFLAGS="-Ofast -fgraphite-identity"
dir=new
collect
report build_scop_depth | tee $dir/report.txt

