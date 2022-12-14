##filter
gffread EVM.all.gff -g 58S.genome.fa -y tr_cds.fa
bioawk -c fastx '$seq < 50 {print $comment}' tr_cds.fa | cut -d '=' -f 2 > short_aa_gene_list.txt
grep -v -w -f short_aa_gene_list.txt EVM.all.gff > filter.gff

## order
python ../sort_evm.py filter.gff filter.gff EVM_sort.gff

## rename
python ../rename.py EVM_sort.gff Os58SG >renamed.gff

#/ifs1/User/pengjx/biosoft/anaconda3/envs/predict/bin/gff3_gene_to_gtf_format.pl renamed.gff 58S.genome.fa > renamed.gtf
# get sequence
/ifs1/User/pengjx/biosoft/anaconda3/envs/predict/bin/gff3_gene_to_gtf_format.pl EVM_sort.gff 58S.genome.fa > test.gtf
gff3_file_to_proteins.pl --gff3 EVM_sort.gff --fasta 58S.genome.fa --seqType prot >test_pro.fasta #ok
#gff3_file_to_proteins.pl --gff3 renamed.gff --fasta 58S.genome.fa --seqType prot >protein.fasta #error, the rename python script is wrong
#gff3_file_to_proteins.pl --gff3 renamed.gff --fasta 58S.genome.fa --seqType CDS >cds.fasta
#gff3_file_to_proteins.pl --gff3 renamed.gff --fasta 58S.genome.fa --seqType cDNA >cDNA.fasta 
#gff3_file_to_proteins.pl --gff3 renamed.gff --fasta 58S.genome.fa --seqType gene >gene.fasta 
