#filter,sort,rename
~/biosoft/geta-2.4.5/bin/gff3_clear.pl --prefix OsY58Sg ../EVM.all.gff >OsY58Sg_nopasa.gff3
~/biosoft/geta-2.4.5/bin/gff3ToGtf.pl ../58S.genome.fa OsY58Sg_nopasa.gff3 >OsY58Sg_nopasa.gtf
/ifs1/User/pengjx/scripts/NGS_v8/bin/bestGeneModels.pl OsY58Sg_nopasa.gff3 >bestGeneModels.gff3 2>geneModelsStatistic

#get fasta
#conda activate evm
/ifs1/User/pengjx/biosoft/anaconda3/envs/evm/bin/gff3_file_to_proteins.pl --gff3 OsY58Sg_nopasa.gff3 --fasta ../58S.genome.fa --seqType prot >protein.fasta
/ifs1/User/pengjx/biosoft/anaconda3/envs/evm/bin/gff3_file_to_proteins.pl --gff3 OsY58Sg_nopasa.gff3 --fasta ../58S.genome.fa --seqType CDS >cds.fasta
/ifs1/User/pengjx/biosoft/anaconda3/envs/evm/bin/gff3_file_to_proteins.pl --gff3 OsY58Sg_nopasa.gff3 --fasta ../58S.genome.fa --seqType cDNA >cDNA.fasta
/ifs1/User/pengjx/biosoft/anaconda3/envs/evm/bin/gff3_file_to_proteins.pl --gff3 OsY58Sg_nopasa.gff3 --fasta ../58S.genome.fa --seqType gene >gene.fasta
