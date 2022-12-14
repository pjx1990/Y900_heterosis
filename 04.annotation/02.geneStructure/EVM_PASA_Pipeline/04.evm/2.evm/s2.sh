/ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/recombine_EVM_partial_outputs.pl --partitions partitions_list.out --output_file_name evm.out

echo -----------------start at `date`-------------------
/ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/convert_EVM_outputs_to_GFF3.pl  --partitions partitions_list.out --output evm.out  --genome 58S.genome.fa
source activate predict
/ifs1/User/pengjx/biosoft/anaconda3/envs/predict/opt/evidencemodeler-1.1.1/EvmUtils/convert_EVM_outputs_to_GFF3.pl  --partitions partitions_list.out --output evm.out  --genome 58S.genome.fa
find . -regex ".*evm.out.gff3" -exec cat {} \; | /ifs1/Software/biosoft/bedtools2/bin/bedtools sort -i - > EVM.all.gff
echo -----------------end at `date`-------------------
