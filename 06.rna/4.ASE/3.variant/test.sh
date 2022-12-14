#6.合并不同样本的vcf文件
##conda activate gatk4
#gatk CombineGVCFs \
#         -R ../0.genome/genome.fa \
#         -V gvcf/R900-1P-1.vcf.gz \
#         -V gvcf/R900-1P-2.vcf.gz \
#         -O test.g.vcf.gz


#7.gvcf转vcf
## GenotypeGVCFs
gatk GenotypeGVCFs \
 -R ../0.genome/genome.fa \
 -V test.g.vcf.gz \
 -O test.vcf.gz
