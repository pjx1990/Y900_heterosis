#conda activate compare
echo -----------start at `date`---------------
qry=/ifs1/User/pengjx/database/homology/all_ref/R900.fa
ref=/ifs1/User/pengjx/database/homology/all_ref/NIP.fa

echo $qry
nucmer -maxmatch -c 90 -l 40 $ref $qry
delta-filter -1 out.delta >filter.delta #too slow slow slow~~~
show-snps -Clr -T filter.delta >filter.snps

python /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/src/mummer-2-vcf.py  -s filter.snps -g $ref --input-header --output-header >all.vcf
python /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/src/mummer-2-vcf.py  -s filter.snps -g $ref --input-header --output-header -t SNP >snp.vcf
python /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/src/mummer-2-vcf.py  -s filter.snps -g $ref --input-header --output-header -t INDEL >indel.vcf
echo -----------end at `date`---------------
