#https://www.jianshu.com/p/d828d45d8b6c
args=commandArgs(T)
library(dplyr)
library(rtracklayer)
#-------------------------------------------------读入转录本组装后的matrix
#expr.gene <- read.csv("stringtie_gene_count_matrix.csv")
expr.gene <- read.csv(args[1])
#-------------------------------------------------读入annotated.gtf
#ensembl_anno <- rtracklayer::import('stringtie_merge.annotated.gtf')
ensembl_anno <- rtracklayer::import(args[2])

ensembl_anno <- as.data.frame(ensembl_anno)

anno_result <- dplyr::left_join(expr.gene,ensembl_anno[,(11:14)],by ="gene_id")

anno_result <- anno_result[!duplicated(anno_result$gene_id),]

name=paste0(gsub("[.]csv","",args[1]),"_rename.csv")
write.csv(anno_result,name,quote=F,col.names=T,row.names=F)
