##conda activate java11
#/ifs1/User/pengjx/database/interproscan/interproscan-5.46-81.0/interproscan.sh -i ../protein.fa -f tsv -cpu 50 -b R900.iprscan -goterms -iprlookup -pa

#looking for TE-related proteins and genes
grep -E "transposon|transposase|intergrase|reverse transcriptase" R900.iprscan.tsv >TE.pep
cut -f 1 TE.pep |sed 's/.t[0-9]//g' |sort -u >TE_gene_Pfam.lst
