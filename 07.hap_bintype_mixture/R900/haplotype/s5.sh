mkdir haplotype
perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/gatk_vcf_to_haplotype_with_varlist.pl --vcf R900_custom.vcf --var 3K-SNP.varlist --out haplotype --nohet

cat haplotype/*.haplotype > R900.haplotype
