#conda activate predict
/ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/partition_EVM_inputs.pl \
        --genome 58S.genome.fa \
        --gene_predictions gene_predictions.gff3 \
        --protein_alignments protein_alignments.gff3 \
        --transcript_alignments transcript_alignments.gff3 \
        --segmentSize 100000 --overlapSize 10000 --partition_listing partitions_list.out
