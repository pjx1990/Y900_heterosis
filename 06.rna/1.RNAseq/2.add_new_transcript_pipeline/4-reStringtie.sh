mkdir ballgown
for i in `ls ../01-hisat2-nocat/bam/*.bam`;do
sample=`basename $i |sed 's/.bam//'`
echo $sample
nohup /ifs1/Software/biosoft/stringtie-1.3.4d.Linux_x86_64/stringtie -e -B -p 2 -G stringtie_merged.gtf -o ballgown/${sample}/${sample}.gtf $i & 
done
