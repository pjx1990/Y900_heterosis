grep 'Chr' 58S.genome.fa |sed 's/>//g' >chr12.lst
seqtk subseq 58S.genome.fa chr12.lst >Y58S.genome.chr1-12.fa
python gap_count.py 58S.genome.fa >>gap.58S.gff3
python gap_count.py R900.genome.fa >>gap.R900.gff3
