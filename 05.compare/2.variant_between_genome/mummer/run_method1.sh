#source activate compare
nucmer --prefix=ref58S_qryR900 ../58S.genome.fa ../R900.genome.fa 
#show-snps -T ref58S_qryR900.delta >ref58S_qryR900.snps
show-snps -Clr -T ref58S_qryR900.delta >ref58S_qryR900.snps
python ../src/mummer-2-vcf.py  -s ref58S_qryR900.snps -g ../58S.genome.fa --input-header --output-header >ref58S_qryR900_all.vcf
python ../src/mummer-2-vcf.py  -s ref58S_qryR900.snps -g ../58S.genome.fa --input-header --output-header -t SNP >ref58S_qryR900_snp.vcf
python ../src/mummer-2-vcf.py  -s ref58S_qryR900.snps -g ../58S.genome.fa --input-header --output-header -t INDEL >ref58S_qryR900_indel.vcf
perl map_chr.pl ref58S_qryR900_snp.vcf >reference58S_snp.xls
perl map_chr.pl ref58S_qryR900_indel.vcf >reference58S_indel.xls
