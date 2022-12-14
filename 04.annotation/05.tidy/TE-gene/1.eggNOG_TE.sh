#cut -f 1,7 R900_eggnog.tsv |grep -v '^#' >GO
#cut -f 1,9 R900_eggnog.tsv |grep -v '^#' >KO
#cut -f 1,16 R900_eggnog.tsv |grep -v '^#' >CAZy

#looking for TE-related pros and genes
grep -E "transposon|transposase|intergrase|reverse transcriptase" R900_eggnog.tsv >TE.pep
cut -f 1 TE.pep |sed 's/.t[0-9]//g' |sort -u >TE_gene_eggNOG.lst
