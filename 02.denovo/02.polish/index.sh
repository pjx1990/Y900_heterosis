gunzip -c ../../1st_pilon/R900.contigs.polish.fasta.gz >R900.contigs.polish.fasta
mkdir index
bwa index -p index/R900 R900.contigs.polish.fasta

