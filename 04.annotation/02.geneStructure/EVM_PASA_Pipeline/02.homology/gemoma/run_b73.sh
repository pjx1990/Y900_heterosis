#conda activate gemoma
mkdir b73
#./pipeline.sh tblastn /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/b73.gff3 /ifs1/User/pengjx/database/homology/MSU7/b73.fa 15 b73
./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/B73v5/Zm-B73-REFERENCE-NAM-5.0_Zm00001e.1.gff3 /ifs1/User/pengjx/database/homology/B73v5/Zm-B73-REFERENCE-NAM-5.0.fa 10 b73
