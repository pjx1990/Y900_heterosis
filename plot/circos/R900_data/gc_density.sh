#https://cloud.tencent.com/developer/article/1448005
faidx genome.fasta -i chromsizes > sizes.genome
bedtools  makewindows -g  sizes.genome  -w  100000 > 100k.bed
bedtools nuc -fi genome.fasta -bed 100k.bed | cut -f 1-3,5 > 100k_gc.bed
sed '1d' 100k_gc.bed >100k_gc_density.txt 
