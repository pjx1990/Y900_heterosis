# conda activate gatk4
#5.call变异
for i in $(ls *.split.bam)
do
i=${i/.split.bam/}
#echo "gatk HaplotypeCaller -R ../0.genome/genome.fa -I ${i}.split.bam -L ../0.genome/genome.interval.list -O ${i}.vcf.gz -dont-use-soft-clipped-bases --standard-min-confidence-threshold-for-calling 20 --dbsnp ${i}.dbSNP_vcf -ERC GVCF ">>run_call.sh
echo "nohup gatk HaplotypeCaller -R ../0.genome/genome.fa -I ${i}.split.bam  -O ${i}.vcf.gz -dont-use-soft-clipped-bases --standard-min-confidence-threshold-for-calling 20 -ERC GVCF &  ">>run_call.sh
done
