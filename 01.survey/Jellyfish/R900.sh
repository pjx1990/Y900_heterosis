# caculate kmer distribute
#ls /ifs1/User/pengjx/project/rawdata/Genome_CleanData/NGS/Clean/R900/*.fq.gz | xargs -n 1 echo gunzip -c > generators
#jellyfish count -g generators -C  -m 31 -s 2G -t 30 -o R900_kmer31.out  
#zcat /ifs1/User/pengjx/project/rawdata/Genome_CleanData/NGS/Clean/R900/*.fq.gz | jellyfish count -C  -m 31 -s 4G -t 30 -o R900_kmer31.out

jellyfish count -C  -m 31 -s 1G -t 30 -o kmer31.out /ifs1/User/pengjx/project/rawdata/Genome_CleanData/NGS/Clean/R900/*.fq

### 生成kmer 统计表;第一列为kmer,第二列为该kmer频数
jellyfish dump  -c -t kmer31.out -L 2 > R900_kmer31.fasta

###统计kmer频数分布
jellyfish histo kmer31.out -o R900_kmer31.histo


conda activate r4-base
Rscript  /ifs1/User/pengjx/biosoft/genomescope2.0-master/genomescope.R -i R900_kmer31.histo  -k 31 -n R900_scope -o ./
