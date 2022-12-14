#7.gvcf转vcf
##conda activate gatk4
## GenotypeGVCFs
gatk GenotypeGVCFs \
 -R ../0.genome/genome.fa \
 -V merge.g.vcf.gz \
 -O merge.vcf.gz

 gatk SelectVariants \
     -R ../0.genome/genome.fa \
     -V merge.vcf.gz \
     --select-type-to-include SNP \
     -O snps.vcf.gz

 gatk SelectVariants \
     -R ../0.genome/genome.fa \
     -V merge.vcf.gz \
     --select-type-to-include INDEL \
     -O indel.vcf.gz
