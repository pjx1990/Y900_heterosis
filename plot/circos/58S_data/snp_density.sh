##https://cloud.tencent.com/developer/article/1593326
##vcftools --vcf snp.bialles.vcf --SNPdensity 100000 --out SNPdensity
#vcftools --vcf /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/reference58S-2/ref58S_qryR900_snp.vcf --SNPdensity 100000 --out SNPdensity_100k
#cut -f 1-3 SNPdensity_100k.snpden |grep -v unanchor |sed '1d' >snp_100k.xls
#awk '$3=$2+100000' snp_100k.xls >tmp
#cut -f 3 snp_100k.xls >tmp2
#paste tmp tmp2 >snp_100k_hist.txt

vcftools --vcf /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/reference58S-2/ref58S_qryR900_indel.vcf --SNPdensity 100000 --out Indeldensity_100k
cut -f 1-3 Indeldensity_100k.snpden |grep -v unanchor |sed '1d' >indel_100k.xls
awk '$3=$2+100000' indel_100k.xls >tmp
cut -f 3 indel_100k.xls >tmp2
paste tmp tmp2 >indel_100k_hist.txt
