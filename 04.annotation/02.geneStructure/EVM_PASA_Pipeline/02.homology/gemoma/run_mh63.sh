#conda activate gemoma
mkdir mh63
#./pipeline.sh tblastn /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/mh63.gff3 /ifs1/User/pengjx/database/homology/MSU7/mh63.fa 15 mh63
#./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MH63/MH63_chr_v2.gff /ifs1/User/pengjx/database/homology/MH63/MH63RS1.LNNK00000000.fa 10 mh63
./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MH63/MH63_chr_v2_del_1064446line.gff /ifs1/User/pengjx/database/homology/MH63/MH63RS1.LNNK00000000.fa 10 mh63
