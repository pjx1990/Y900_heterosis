#conda activate compare
echo -----------start at `date`---------------
qry=/ifs1/User/pengjx/database/homology/all_ref/Y58S.fa
ref=/ifs1/User/pengjx/project/Rice/07.compare/Y58S/variant/cell_58s.fa

nucmer -c 90 -l 40 $ref $qry
delta-filter -m -i 90 -l 100 out.delta >filter.delta
show-snps -Clr -T filter.delta >filter.snps

python /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/src/mummer-2-vcf.py  -s filter.snps -g $ref --input-header --output-header >all.vcf
python /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/src/mummer-2-vcf.py  -s filter.snps -g $ref --input-header --output-header -t SNP >snp.vcf
python /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/src/mummer-2-vcf.py  -s filter.snps -g $ref --input-header --output-header -t INDEL >indel.vcf
echo -----------end at `date`---------------
