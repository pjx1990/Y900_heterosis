# conda activate 3k
gatk3 \
    -R /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/HAP-R900/bam/MSU7.fasta \
    -T UnifiedGenotyper \
    -I ../bam/R900.bam \
    -o R900_custom.vcf \
    --output_mode EMIT_ALL_SITES \
    -L 3k_SNP.bed

    #--dbsnp dbSNP.vcf \
    #-I ../bam/R900_565.rmdup.bam \
