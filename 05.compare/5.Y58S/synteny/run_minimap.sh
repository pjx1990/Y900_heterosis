#!/bin/bash
query=our_58s.fa
target=cell_58s.fa
outname="${query%.*}_${target%.*}_minimap2.paf"
/ifs1/Software/biosoft/minimap2/minimap2 -x asm5 -t 36 $target $query > ${outname}
