for i in `ls ../01-hisat2-nocat/bam/*.bam`;do
sample=`basename $i |sed 's/.bam//'`
echo $sample
/ifs1/Software/biosoft/samtools/samtools flagstat  $i >../01-hisat2-nocat/mappingRate/${sample}.flagstat &

nohup /ifs1/Software/biosoft/stringtie-1.3.4d.Linux_x86_64/stringtie -p 2 -G /ifs1/User/pengjx/database/homology/MSU7/msu7.gtf -o gtf/${sample}.gtf -l ${sample} $i &
echo "gtf/${sample}.gtf" >>mergelist.txt
done
