#conda activate gemoma
mkdir msu7
#./pipeline.sh tblastn /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/msu7.gff3 /ifs1/User/pengjx/database/homology/MSU7/msu7.fa 15 msu7
./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/msu7.gff3 /ifs1/User/pengjx/database/homology/MSU7/msu7.fa 10 msu7
