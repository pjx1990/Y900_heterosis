makeblastdb -in TIGR_Oryza_Repeats.v3.3  -dbtype nucl -parse_seqids

tblastn -query /ifs1/User/pengjx/project/Rice/06.annotation/final/Y58S/Y58S.pep.fa -db TIGR_Oryza_Repeats.v3.3 -evalue 1e-5 -num_threads 20 -outfmt 6 -out Y58S_TE_tblastn.out

cut -f 1 Y58S_TE_tblastn.out |sed 's/.t[0-9]//g' |sort -u >TE_gene_tblastn.lst
