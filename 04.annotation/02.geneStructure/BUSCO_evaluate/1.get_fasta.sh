#filter,sort,rename
gff3_clear.pl --prefix OsR900g ../sqlite.gene_structures_post_PASA_updates.1293046.gff3 >OsR900g_pasa3.gff3
gff3ToGtf.pl ../R900.genome.fa OsR900g_pasa3.gff3 >OsR900g_pasa3.gtf
/ifs1/User/pengjx/scripts/NGS_v8/bin/bestGeneModels.pl OsR900g_pasa3.gff3 >bestGeneModels.gff3 2>geneModelsStatistic

#get fasta
/ifs1/User/pengjx/biosoft/anaconda3/envs/predict/bin/gff3_file_to_proteins.pl --gff3 OsR900g_pasa3.gff3 --fasta ../R900.genome.fa --seqType prot >protein.fasta
/ifs1/User/pengjx/biosoft/anaconda3/envs/predict/bin/gff3_file_to_proteins.pl --gff3 OsR900g_pasa3.gff3 --fasta ../R900.genome.fa --seqType CDS >cds.fasta
/ifs1/User/pengjx/biosoft/anaconda3/envs/predict/bin/gff3_file_to_proteins.pl --gff3 OsR900g_pasa3.gff3 --fasta ../R900.genome.fa --seqType cDNA >cDNA.fasta
/ifs1/User/pengjx/biosoft/anaconda3/envs/predict/bin/gff3_file_to_proteins.pl --gff3 OsR900g_pasa3.gff3 --fasta ../R900.genome.fa --seqType gene >gene.fasta
