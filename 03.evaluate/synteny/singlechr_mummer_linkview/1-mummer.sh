/ifs1/Software/biosoft/mummer-4.0.0beta2/nucmer R900.fasta R498.fasta
/ifs1/Software/biosoft/mummer-4.0.0beta2/delta-filter -i 89 -l 1000 -1 out.delta > out.delta.filter #比对率大于89%，对比长度大于1000
/ifs1/Software/biosoft/mummer-4.0.0beta2/show-coords out.delta.filter > out.coords
#grep -P  "chr1\s+" out.delta.coord|awk '{print $12,$13}' |sort |uniq -c
grep -P  "Chr1$" out.coords |awk '{print $12,$13}' |sort |uniq -c
