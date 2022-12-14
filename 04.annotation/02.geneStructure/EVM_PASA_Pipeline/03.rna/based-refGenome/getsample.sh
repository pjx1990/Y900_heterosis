ls fq/* |while read i;do
#echo $i
#echo ${i:3:14}
sample=${i:3:14}
echo "${sample} fq/${sample}_1.fq.gz    fq/${sample}_2.fq.gz" >>tmp
done

cat tmp |sort -u >sample.info
