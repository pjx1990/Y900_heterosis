ln -s /ifs1/User/pengjx/project/rawdata/HiC-Report-20201126/R900/R900.fasta .
bwa index R900.fasta
for i in $(seq 565 572) ;do 
nohup bwa mem  R900.fasta -t 4 /ifs1/User/pengjx/project/rawdata/Genome_CleanData/NGS/Clean/R900/PADsmpDAAAA-${i}_1.fq  /ifs1/User/pengjx/project/rawdata/Genome_CleanData/NGS/Clean/R900/PADsmpDAAAA-${i}_2.fq  1>R900_${i}.sam 2>R900_${i}.bwa.align.log &
done
