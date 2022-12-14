ln -s path/*.bam .
cat Rawdata/* >proteins.fasta  #Orthodb protein

#conda activate braker2
/ifs1/User/pengjx/biosoft/anaconda3/envs/braker2/ProtHint-2.6.0/bin/prothint.py /ifs1/User/pengjx/database/assembly/58S.genome.masked.fa proteins.fasta --workdir 58S --threads 40 
