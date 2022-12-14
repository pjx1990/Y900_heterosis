gtf_genome_to_cdna_fasta.pl rna-seq/merged.gtf 58S.genome.masked.fa >transcripts.fasta
gtf_to_alignment_gff3.pl rna-seq/merged.gtf > transcripts.gff3

TransDecoder.LongOrfs -t transcripts.fasta
TransDecoder.Predict -t transcripts.fasta
cdna_alignment_orf_to_genome_orf.pl transcripts.fasta.transdecoder.gff3 transcripts.gff3 transcripts.fasta > transcripts.fasta.transdecoder.genome.gff3
