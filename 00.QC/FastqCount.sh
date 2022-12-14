for i in `seq 573 580`;do
echo $i
pigz -dc PADsmpDAAAB-${i}_1.fq.gz PADsmpDAAAB-${i}_2.fq.gz |/ifs1/User/pengjx/biosoft/FastqCount/FastqCount_v0.5 - >>fq.stat
done
