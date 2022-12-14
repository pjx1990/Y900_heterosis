/ifs1/User/pengjx/biosoft/juicer/scripts/juicer.sh \
	-g genome \
	-s MboI \
	-z reference/genome.fa \
	-y reference/genome_DpnII.txt \
	-p reference/genome.chrom.size \
	-D /ifs1/User/pengjx/biosoft/juicer \
	-t 50 &> juicer.log &
