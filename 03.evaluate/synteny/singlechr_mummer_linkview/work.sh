#grep -P  "HiC_scaffold_(.*)\s+Chr1$" out.coords|awk '{print $12,$1,$2,$13,$4,$5}' |len
grep -P  "HiC_scaffold_8\s+Chr1$" out.coords|awk '{print $12,$1,$2,$13,$4,$5}' >hic8_chr1.pos
sed -i 's/ /\t/g' hic8_chr1.pos
python /ifs1/User/pengjx/biosoft/LINKVIEW-1.1/LINKVIEW.py hic8_chr1.pos -o hic8_chr1
