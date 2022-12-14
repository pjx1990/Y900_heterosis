#grep -P  "Superscaffold1_6_43788308\s+Chr1$" out.coords|awk '{print $12,$1,$2,$13,$4,$5}' >scaffold1_chr1.pos
#sed -i 's/  /\t/g' scaffold1_chr1.pos
#python /ifs1/User/pengjx/biosoft/LINKVIEW-1.1/LINKVIEW.py scaffold1_chr1.pos -o scaffold1_chr1
for i in {1..12};do
grep -P  "Superscaffold${i}_(.*)\s+Chr${i}$" out.coords|awk '{print $12,$1,$2,$13,$4,$5}' >scaffold${i}_chr${i}.pos
sed -i 's/  /\t/g' scaffold${i}_chr${i}.pos
python /ifs1/User/pengjx/biosoft/LINKVIEW-1.1/LINKVIEW.py scaffold${i}_chr${i}.pos -o scaffold${i}_chr${i}
done
