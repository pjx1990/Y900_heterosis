#conda activate gatk4
for i in `ls ../1.bam/*.marked.bam`
    do
    sample=`basename $i |sed 's/.marked.bam//'`
echo $sample
#    gatk ASEReadCounter \
#        -R ../0.genome/genome.fa \
#        -I ${i} \
#        -V ../3.variant/snps.filter_pass.vcf.gz \
#        -min-depth 10 \
#        -O ${sample}.ASE.table.txt \
#        --verbosity ERROR
nohup gatk ASEReadCounter  -R ../0.genome/genome.fa -I ${i}  -V ../3.variant/snps.filter_pass.vcf.gz -min-depth 8 -O ${sample}.ASE.table.txt --verbosity ERROR  &
done
