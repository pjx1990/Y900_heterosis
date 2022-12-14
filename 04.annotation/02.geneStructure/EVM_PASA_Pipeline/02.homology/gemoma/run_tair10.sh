#conda activate gemoma
mkdir tair10
#./pipeline.sh tblastn /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/tair10.gff3 /ifs1/User/pengjx/database/homology/MSU7/tair10.fa 15 tair10
./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/TAIR10/TAIR10_GFF3_genes.gff /ifs1/User/pengjx/database/homology/TAIR10/TAIR10_changeChr.fa 15 tair10
