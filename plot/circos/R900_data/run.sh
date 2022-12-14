sed '/^unanchor/d' R900.gff3 >genome.gff3
# 准备用于circos画图的数据文件
# 通过基因组序列，生成染色体组型文件
circos_create_karyotype_by_genome.pl genome.fasta > karyotype.txt
# band 信息使用MCScanX的共线性区块信息
# circos_create_karyotype_band_by_MCScanX.pl data/nc_cp.gff data/nc_cp.collinearity_interspecific 15 1 > karyotype.band_for_circos.txt
cat ~/00.incipient_data/data_for_circos/karyotype.band_for_circos.txt >> karyotype.txt

# 通过基因组序列，生成GC含量结果文件，用于画直方图
circos_create_gc_histogram.pl genome.fasta 100000 > gc.histogram.txt

# 生成SNP密度结果文件，用于画直方图
VCF_get_variants_density_for_circos.pl ~/00.incipient_data/data_for_variants_calling/variants.vcf genome.fasta > variant_density.histogram_for_circos.txt

# 通过转录组数据，得到基因表达量的结果文件，用于画热图
cut -f 1,2,5 ~/09.RNA-seq_analysis_by_cufflinks/cuffnorm/gene.TPM.TMM.matrix > gene.TPM.TMM.matrix
circos_create_expression_heatmap.pl gene.TPM.TMM.matrix genome.gff3 > gene_expression.heatmap.txt

# 通过基因组自身比较，用于画links图
makeblastdb -in genome.fasta -dbtype nucl -title genome -parse_seqids -out genome 
blastn -query genome.fasta -db genome -out blast.out -evalue 1e-5 -outfmt 6 -num_threads 8
# 计算耗时~2min。
perl -e 'while (<>) { @_ = split /\t/; print if $_[6] ne $_[8] && $_[2] >= 90 && $_[3] >= 1000 }' blast.out | sort -k 1.13n -k 7n > similarity.txt
perl -e 'while (<>) { @_ = split /\t/; if ($_[3] >= 3000) { print } else { print STDERR } }' similarity.txt > similarity_3000.txt 2> similarity_1000.txt
perl -e 'while (<>) { @_ = split /\t/; print "$_[0]\t$_[6]\t$_[7]\t$_[1]\t$_[8]\t$_[9]\n"; }' similarity_1000.txt > similarity_1000.links.txt
perl -e 'while (<>) { @_ = split /\t/; print "$_[0]\t$_[6]\t$_[7]\t$_[1]\t$_[8]\t$_[9]\n"; }' similarity_3000.txt > similarity_3000.links.txt

