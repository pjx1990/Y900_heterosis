cat glimmerhmm4evm.gff augustus4evm.gff >../gene_predictions.gff3
cat gemoma4evm.gff exonerate.gff3 >../protein_alignments.gff3
# add msu7 cda and pasa predict result
cat Oryza_mRNA.gff3 MSU7_cdna.gff3 transcripts.fasta.transdecoder.genome.gff3 mydb.sqlite.assemblies.fasta.transdecoder.genome.gff3 >../transcript_alignments.gff3


##在weights中设置权重，每个证据来源都可设置不同权重，即使是MSU和栽培稻证据，只要gff第二列feature不同
