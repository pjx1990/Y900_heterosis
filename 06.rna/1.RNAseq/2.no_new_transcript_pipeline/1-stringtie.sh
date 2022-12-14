for i in `ls ../01-hisat2/bam/*.bam`;do
sample=`basename $i |sed 's/.bam//'`
echo $sample

#nohup /ifs1/Software/biosoft/stringtie-1.3.4d.Linux_x86_64/stringtie -p 3 -G /ifs1/User/pengjx/database/homology/MSU7/msu7.gtf -o gtf/${sample}.gtf -B -e -l ${sample} $i & 

echo "$sample   ./gtf/${sample}.gtf" >>gtflist.txt
done
