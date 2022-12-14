##从稻属中取水稻序列
#grep -i "Oryza sativa" oryza_mRNA2.fasta |sed 's/^>//g' >riceID.list
#faSomeRecords oryza_mRNA2.fasta riceID.list rice_mRNA.fasta
/ifs1/User/pengjx/biosoft/gmap/bin/gmap -D ./ -t 30 -d R900 -S rice_mRNA.fasta --max-intronlength-middle=100000 >R900-ncbiRicemRNA_gmap.out 
