#############################
### 水稻已知功能基因表达模式
##  包括黄学辉RiceNavi和funRiceGenes
############################
rm(list = ls())
library(tidyverse)

setwd("F:\\杂优中心\\杂种优势表达模式\\DESeq2\\stringtieNonovel\\杂优模式\\功能基因")

allQTN <- read.delim("黄学辉_QTN.txt",header = T,sep = "\t")
colnames(allQTN)

funrice <- read.delim("funRice_known_cloned_gene.txt",header = T,sep = "\t")
# funrice$MSU
# unlist(strsplit("LOC_Os07g40510|LOC_Os07g40520","[|]"))
x <- unlist(sapply(funrice$MSU,function(x)unlist(strsplit(x,"[|]"))))
y=data.frame(x)
z <- y[y!="None",]
c("LOC_Os03g21400","LOC_Os03g21419") %in% z


##黄学辉功能基因和funRice数据库功能基因比较
length(unique(allQTN$MSU_ID))
length(z)
length(unique(z))
length(intersect(unique(allQTN$MSU_ID),unique(z)))
length(union(unique(allQTN$MSU_ID),unique(z)))
funrice_uniq <- setdiff(unique(z),unique(allQTN$MSU_ID))


tpm <- read.csv("../../36sample_allExpGene_TPM_matrix.csv",header = T)
colnames(tpm)


##黄学辉功能基因匹配
QTN <- allQTN[match(unique(allQTN$MSU_ID),allQTN$MSU_ID),]
colnames(QTN)
length(QTN$MSU_ID)
length(unique(QTN$MSU_ID))
QTN_exp <- left_join(QTN,tpm,by=c("MSU_ID"="X"))
write.csv(QTN_exp,"黄学辉_QTN_匹配基因.csv",row.names = F)

## 黄学辉功能基因中 Y58S and R900 diff QTN sites
colnames(QTN_exp)
idx=apply(QTN_exp,1,function(x){x[10]!=x[11]})
diffQTN <- QTN_exp[idx,]
na_idx <- apply(diffQTN, 1, function(x){all(is.na(x))})
diffQTN <- diffQTN[!na_idx,]
write.csv(diffQTN,"黄学辉_QTN_亲本序列差异_匹配基因.csv",row.names = F)

##黄学辉功能基因中仅双亲序列差异，其他参考基因组序列相同
colnames(diffQTN)
idx2=apply(diffQTN,1,function(x) ((x[10]==x[12]) && (x[10]==x[13]) && (x[10]==x[14]) && (x[10]==x[15]) && (x[10]==x[16]) && (x[10]==x[17])) |
             ((x[11]==x[12]) && (x[11]==x[13]) && (x[11]==x[14]) && (x[11]==x[15]) && (x[11]==x[16]) && (x[11]==x[17])))
idx2
unique_diff <- diffQTN[idx2,]
write.csv(unique_diff,"黄学辉_QTN_仅双亲序列差异_匹配基因.csv",row.names = F)

## plot heatmap
colnames(QTN_exp)
plot_QTN <- QTN_exp[c(5:6,18:53)]
plot_QTN <- plot_QTN[!duplicated(plot_QTN$Gene),]
rownames(plot_QTN) <- plot_QTN$Gene
plot_QTN <- na.omit(plot_QTN)
plot_QTN[plot_QTN==0] <- NA
plot_QTN[is.na(plot_QTN)] <- min(plot_QTN[-c(1:2)],na.rm = T)*0.01

annotation_row=data.frame(Category=plot_QTN[,2])
rownames(annotation_row)=plot_QTN$Gene
annotation_col = data.frame(Tissue=rep(rep(c("1P","5P","L","S"),each=3),times=3))
rownames(annotation_col)=colnames(plot_QTN)[-c(1:2)]
pheatmap::pheatmap(log2(plot_QTN[-c(1:2)]),
                   annotation_col = annotation_col,
                   annotation_row = annotation_row)
#width=12;height=25



## funRice数据库中除黄学辉功能基因外的其他基因

funr <- funrice[match(funrice_uniq,funrice$MSU),]
row.na <- apply(funr, 1, function(x){all(is.na(x))})
funr2 <- funr[!row.na,]
fun_exp <- left_join(funr2,tpm,by=c("MSU"="X"))
write.csv(fun_exp,"funRiceGenes.csv",row.names = F)

## plot heatmap
fun_exp_duprm <- fun_exp[!duplicated(fun_exp$Symbol),]
rownames(fun_exp_duprm) <- fun_exp_duprm$Symbol
fun_exp_plot <- fun_exp_duprm[-c(1:6)]
fun_exp_plot[fun_exp_plot==0] <- NA
fun_exp_plot[is.na(fun_exp_plot)] <- min(fun_exp_plot[-c(1:2)],na.rm = T)*0.01
pheatmap::pheatmap(log2(fun_exp_plot),show_rownames = F,
                   annotation_col = annotation_col)
#width=9;height=8



# 合并两者 ------------------------------------------------------------


inter <- intersect(unique(allQTN$MSU_ID),unique(z))
funrice_uniq <- setdiff(unique(z),unique(allQTN$MSU_ID))
qtn_uniq <- setdiff(unique(allQTN$MSU_ID),unique(z))

length(union(unique(allQTN$MSU_ID),unique(z)))
length(inter)+length(funrice_uniq)+length(qtn_uniq)

merge_two <- data.frame(MSU=c(inter,qtn_uniq,funrice_uniq),
                        Source=c(rep("QTN-funRice",length(inter)),
                                 rep("QTN",length(qtn_uniq)),
                                 rep("funRice",length(funrice_uniq)))
)

merge1 <- full_join(merge_two,funrice,by=c("MSU"))
merge2 <- full_join(merge1,allQTN,by=c("MSU"="MSU_ID"))
merge3 <- left_join(merge2,tpm,by=c("MSU"="X"))

write.csv(merge3,"all_QTN_funRiceGenes.csv",row.names = F)
allgenelst <- union(unique(allQTN$MSU_ID),unique(z))
write.table(allgenelst,"all_QTN_funRiceGenes.lst",sep = "\t",quote = F,row.names = F,col.names = F)

## plot
colnames(merge3)
all_plot <- merge3[c(1,24:59)]
# allfungene <- all_plot %>% filter(grepl("^LOC_",MSU))
all_plot <- na.omit(all_plot)
colnames(all_plot)
all_plot2 <- all_plot[!duplicated(all_plot$MSU),]
rownames(all_plot2) <- all_plot2$MSU
all_plot2[all_plot2==0] <- NA
all_plot2[is.na(all_plot2)] <- min(all_plot2[-c(1)],na.rm = T)*0.01
pheatmap::pheatmap(log2(all_plot2[-1]),show_rownames = F,
                   annotation_col = annotation_col)
#width=9;height=8