python /ifs1/User/pengjx/biosoft/juicer/misc/generate_site_positions.py DpnII genome genome.fa

awk 'BEGIN{OFS="\t"}{print $1, $NF}' genome_DpnII.txt > genome.chrom.size
