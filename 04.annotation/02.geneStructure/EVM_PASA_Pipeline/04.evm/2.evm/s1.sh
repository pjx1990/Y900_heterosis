/ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/write_EVM_commands.pl --genome 58S.genome.fa --weights `pwd`/weights.txt \
              --gene_predictions gene_predictions.gff3 \
              --protein_alignments protein_alignments.gff3 \
              --transcript_alignments transcript_alignments.gff3 \
              --output_file_name evm.out  --partitions partitions_list.out >  commands.list

echo ----------------starts `date`-----------------
/ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/execute_EVM_commands.pl commands.list | tee run.log

echo ----------------ends `date`-----------------

