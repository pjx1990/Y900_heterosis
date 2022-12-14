#!/bin/bash
query=$1
target=$2
outname="${query%.*}_${target%.*}_minimap2.paf"
/ifs1/Software/biosoft/minimap2/minimap2 -x asm5 -t 36 $target $query > ${outname}
