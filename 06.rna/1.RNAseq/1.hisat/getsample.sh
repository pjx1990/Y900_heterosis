for i in `ls ../fq/*.fq.gz`;do
fq=`basename $i`
sample=`echo $fq |sed 's/_[0-9].fq.gz//'`
echo $fq 
echo $sample
echo "${sample} ../fq/${sample}_1.fq.gz    ../fq/${sample}_2.fq.gz" >>tmp
done

cat tmp |sort -u >sample.info
rm tmp
