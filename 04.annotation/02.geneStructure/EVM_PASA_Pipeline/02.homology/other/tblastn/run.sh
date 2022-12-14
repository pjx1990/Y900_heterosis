#makeblastdb -in 58S.repeat.masked.fa -parse_seqids -dbtype nucl -out index/58S
nohup tblastn -query all_pep.fa -out 58S.blast -db index/58S -outfmt 6 -evalue 1e-10 -num_threads 20 -qcov_hsp_perc 50.0 -num_alignments 5 &
