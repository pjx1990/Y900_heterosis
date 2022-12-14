perl /ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/misc/GeMoMa_gff_to_gff3.pl homology_species.gff >gemoma4evm.gff
perl /ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/misc/augustus_GFF3_to_EVM_GFF3.pl 58S.augustus.gff >augustus4evm.gff
perl /ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/misc/glimmerHMM_to_GFF3.pl glimmerhmm_all.gff3 >glimmerhmm4evm.gff
#perl /ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/misc/SNAP_to_GFF3.pl 58S.snap.gff3 >snap4evm.gff

#cat glimmerhmm4evm.gff 58S.snap.gff3 augustus4evm.gff >../gene_predictions.gff3
#cat gemoma4evm.gff >../protein_alignments.gff3
#cat all_oryza_mRNA.gff3 transcripts.fasta.transdecoder.genome.gff3 >../transcript_alignments.gff3
