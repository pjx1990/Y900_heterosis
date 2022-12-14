#6.合并不同样本的vcf文件
#conda activate gatk4
gatk CombineGVCFs \
         -R ../0.genome/genome.fa \
         -V gvcf/R900-1P-1.vcf.gz -V gvcf/R900-1P-2.vcf.gz -V gvcf/R900-1P-3.vcf.gz \
         -V gvcf/R900-5P-1.vcf.gz -V gvcf/R900-5P-2.vcf.gz -V gvcf/R900-5P-3.vcf.gz \
         -V gvcf/R900-L1.vcf.gz -V gvcf/R900-L2.vcf.gz -V gvcf/R900-L3.vcf.gz \
         -V gvcf/R900-S1.vcf.gz -V gvcf/R900-S2.vcf.gz -V gvcf/R900-S3.vcf.gz \
         -V gvcf/Y58S-1P-1.vcf.gz -V gvcf/Y58S-1P-2.vcf.gz -V gvcf/Y58S-1P-3.vcf.gz \
         -V gvcf/Y58S-5P-1.vcf.gz -V gvcf/Y58S-5P-2.vcf.gz -V gvcf/Y58S-5P-3.vcf.gz \
         -V gvcf/Y58S-L1.vcf.gz -V gvcf/Y58S-L2.vcf.gz -V gvcf/Y58S-L3.vcf.gz \
         -V gvcf/Y58S-S1.vcf.gz -V gvcf/Y58S-S2.vcf.gz -V gvcf/Y58S-S3.vcf.gz \
         -V gvcf/Y900-1P-1.vcf.gz -V gvcf/Y900-1P-2.vcf.gz -V gvcf/Y900-1P-3.vcf.gz \
         -V gvcf/Y900-5P-1.vcf.gz -V gvcf/Y900-5P-2.vcf.gz -V gvcf/Y900-5P-3.vcf.gz \
         -V gvcf/Y900-L1.vcf.gz -V gvcf/Y900-L2.vcf.gz -V gvcf/Y900-L3.vcf.gz \
         -V gvcf/Y900-S1.vcf.gz -V gvcf/Y900-S2.vcf.gz -V gvcf/Y900-S3.vcf.gz \
         -O merge.g.vcf.gz
