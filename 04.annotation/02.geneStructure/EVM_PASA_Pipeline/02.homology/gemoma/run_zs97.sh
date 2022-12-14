#conda activate gemoma
mkdir zs97
#./pipeline.sh tblastn /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/zs97.gff3 /ifs1/User/pengjx/database/homology/MSU7/zs97.fa 15 zs97
./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/ZS97/ZS97_chr_v2.gff /ifs1/User/pengjx/database/homology/ZS97/ZS97RS1.LNNJ00000000.fa 30 zs97
