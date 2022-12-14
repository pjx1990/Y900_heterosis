#conda activate gemoma
mkdir 9311
#./pipeline.sh tblastn /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/MSU7/9311.gff3 /ifs1/User/pengjx/database/homology/MSU7/9311.fa 15 9311
./pipeline.sh mmseq /ifs1/User/pengjx/database/assembly/R900.genome.fa /ifs1/User/pengjx/database/homology/9311/Oryza_indica.ASM465v1.50.gff3 /ifs1/User/pengjx/database/homology/9311/Oryza_indica.ASM465v1.dna.toplevel.fa 10 9311
