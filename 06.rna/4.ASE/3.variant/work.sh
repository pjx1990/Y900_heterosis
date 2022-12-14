plink --vcf snps.filter_pass.vcf.gz --recode --out snp --double-id --allow-extra-chr --make-bed
plink --bfile snp --recode vcf-iid --allow-extra-chr --out snp
