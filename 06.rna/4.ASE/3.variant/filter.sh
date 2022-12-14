#conda activate gatk4
gatk VariantFiltration \
         -R ../0.genome/genome.fa \
         -V ../2.call/snps.vcf.gz \
         -filter "QD < 2.0" --filter-name "QD2" \
         -filter "FS > 60.0" --filter-name "FS60" \
         -filter "QUAL < 30.0" --filter-name "QUAL30" \
         -filter "SOR > 3.0" --filter-name "SOR3" \
         -filter "MQ < 40.0" --filter-name "MQ40" \
         -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
         -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
         -O snps.filter_raw.vcf.gz

#select PASS and biallelic SNPs
bcftools view --threads 4 -m1 -M2 -f PASS -Oz -o snps.filter_pass.vcf.gz snps.filter_raw.vcf.gz
bcftools index --threads 4 -f -t snps.filter_pass.vcf.gz




gatk VariantFiltration \
         -R ../0.genome/genome.fa \
         -V ../2.call/indel.vcf.gz \
         -filter "QD < 2.0" --filter-name "QD2" \
         -filter "FS > 200.0" --filter-name "FS200" \
         -filter "QUAL < 30.0" --filter-name "QUAL30" \
         -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" \
         -O indel.filter_raw.vcf.gz

bcftools view --threads 4 -m1 -M2 -f PASS -Oz -o indel.filter_pass.vcf.gz indel.filter_raw.vcf.gz
bcftools index --threads 4 -f -t indel.filter_pass.vcf.gz
