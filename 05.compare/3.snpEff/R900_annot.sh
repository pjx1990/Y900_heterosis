#java -jar snpEff/snpEff.jar build -gff3 rice
head -31 /ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/syri.vcf >header
grep -v '^#' /ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/syri.vcf |grep -v '>' >tmp
cat header tmp >/ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/syri_snpindel.vcf
grep -v '^#' /ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/syri.vcf |grep '>' >tmp2
cat header tmp2 >/ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/syri_sv.vcf

## snpEff注释syri结果只能注释snp和indel，sv变异会有位置先后错误（不是很严格的vcf格式）。因此单独提取snp和indel进行注释
java -jar snpEff/snpEff.jar -v rice /ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/syri_snpindel.vcf >/ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/R900_syri_snpindel.anno.vcf

mv snpEff_summary.html /ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/R900_snpEff_summary.html
mv snpEff_genes.txt /ifs1/User/pengjx/project/Rice/07.compare/compare_NIP/R900-NIP/syri/R900_snpEff_genes.txt

rm tmp tmp2
