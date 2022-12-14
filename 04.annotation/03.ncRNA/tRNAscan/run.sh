tRNAscan-SE 58S.genome.fa -o 58S_tRNA.out -f 58S_tRNA.ss -m 58S_tRNA.stats
perl convert_tRNAScanSE_to_gff3.pl -i 58S_tRNA.out >Y58S.tRNAscan.gff3
