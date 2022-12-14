grep 'Chr' 58S.genome.fa |sed 's/>//g' >chr12.lst
seqtk subseq 58S.genome.fa chr12.lst >Y58S.genome.chr1-12.fa
python gap_count.py 58S.genome.fa >>gap.58S.gff3

#统计长度
seqkit fx2tab --length --name --header-line 58S.genome.fa >58S.len
awk '{sum+=$2}END{print sum}' 58S.len
