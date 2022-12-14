#conda activate gemoma
mkdir R498 
#./pipeline.sh tblastn /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/msu7.gff3 /ifs1/User/pengjx/database/homology/MSU7/msu7.fa 15 msu7
./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/R498/MBKbase/R498_IGDBv3_allset.gff /ifs1/User/pengjx/database/homology/R498/MBKbase/R498_Chr.fasta 10 R498
