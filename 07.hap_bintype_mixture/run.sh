## https://github.com/zhuochenbioinfo/3KRG-HAP
# snp pruning 
#perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/SNP_pruning.r2.pl --in ../3k.vcf --out 3K-RG.geno

# haplotype construction
#perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/geno_to_binhap.pl --in 3K-RG.geno --out 3K-HAP.haplotype

# NAF-score calculate
# test
# perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/haplotype_to_subtype_standard.pl 3K-HAP.haplotype/1/1_04324.haplotype /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/data/3K-RG.sample_list 3K-HAP.haplotype.NAF_score
 cat 3K-HAP.haplotype/*/* >cat_3K-HAP.haplotype
perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/haplotype_to_subtype_standard.pl cat_3K-HAP.haplotype /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/data/3K-RG.sample_list 3K-HAP.haplotype.NAF_score


#genotyping in custom population


# 5.haplotype contruction in custom pop
cat 3K-RG.geno | grep -v "^#"| awk '{bin=int(($2-1)/10000);name=sprintf("%05d",bin);print $1"\t"$2"\t"$3"\t"$4"\t"$1"_"name}' > 3K-SNP.varlist

#perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/gatk_vcf_to_haplotype_with_varlist.pl --vcf R900_sample.vcf -var 3K-SNP.varlist --out custom.haplotype --nohet 
#perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/gatk_vcf_to_haplotype_with_varlist.pl --vcf R900_custom.vcf -var 3K-SNP.varlist --out custom.haplotype --nohet 
#perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/gatk_vcf_to_haplotype_with_varlist.pl --vcf ../../HAP-R900/callvcf/custom_test.vcf -var 3K-SNP.varlist --out custom.haplotype --nohet
#perl gatk_vcf_to_haplotype_with_varlist.pl --vcf cj.snps.filter.vcf --var 3K-SNP.varlist --out custom.haplotype --nohet
perl gatk_vcf_to_haplotype_with_varlist.pl --vcf ../../HAP-R900/callvcf/custom_test.vcf -var 3K-SNP.varlist --out custom.haplotype --nohet

cat custom.haplotype/*haplotype >custom.hap

#perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/scan_haplotype_stdratio.pl test_step6/R900.hapratio window.10k.bin.bed2 sample.bin_NAF
perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/scan_haplotype_stdratio.pl test_step6/R900.hapratio window.10k.bin.bed2.txt sample.bin_NAF
perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/dissect_rice_bin.pl sample.bin_NAF > sample.bin_NAF2
Rscript /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/draw_bin.rice.R test/chr.len sample.bin_NAF2 sample.bin_NAF2.pdf
