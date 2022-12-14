###################
### DESeq2 未检测新的转录本
## 删除样本R900.1P.1和R900.S3
## 1P和5P合并或不合并
###################
rm(list = ls())

setwd("F:\\杂优中心\\杂种优势表达模式\\DESeq2\\stringtieNonovel\\DESeq2")
library(DESeq2)
library(dplyr)
library(tidyr)
library(ggplot2)

data <- read.csv("gene_count.csv",header = T)
head(data)
colnames(data)

newdata2 <- select(data,-c(R900.S3,R900.1P.3))
colnames(newdata2) <- gsub("[.]","_",colnames(newdata2))
colnames(newdata2) <- gsub("P_","P",colnames(newdata2))
colnames(newdata2)

newdata3=newdata2[which(rowSums(newdata2[-1])>0),]


# 相同组织不同品种差异 ----------------------------------------------------

##############Tissue P （合并1P和5P）##########################################################

##-------- R900-vs-Y58S
colnames(newdata3)
rownames(newdata3) <- newdata3$gene_id
CountMatrix1=newdata3 %>% select(contains("R900_1P") |contains("R900_5P") |contains("Y58S_1P") |contains("Y58S_5P"))

CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
# sample_n <- gsub("(.*)\\d$","\\1",colnames(CountMatrix1))
# res_name <- paste0(unique(sample_n)[1],"-VS-",unique(sample_n)[2])

#前者control对照组，后者为case实验组
#得到的结果是control vs case
# ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("ctrlrep","ISrep"),each=3))
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y58S"),times=c(5,6))) 
#生成DESeqDataSet数据集
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
#DESeq差异表达计算
dds<-DESeq(dds) 
#生成差异表达结果
# nrow(dds)
# dds_filter <- dds[ rowSums(counts(dds))>1, ] ##将所有样本基因表达量之和小于1的基因过滤掉
# nrow(dds_filter) 
nrow(dds)
dds <- dds[ rowSums(counts(dds))>1, ] ##将所有样本基因表达量之和小于1的基因过滤掉
nrow(dds)
res<-results(dds)  
summary(res) 
#查看总结信息（表达上调，下调等）
head(res)
#统计padj（adjusted p-value）小于0.05的数目
table(res$padj <0.05)
#统计padj（adjusted p-value）小于0.05的数目
res<- res[order(res$padj),]#按padj排序
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "P_R900-vs-Y58S_all.csv",row.names = F)
#输出结果到csv文件
# deg <- subset(res, padj <= 0.01 & abs(log2FoldChange) >= 1) #筛选显著差异表达基因（padj小于0.01且FoldChange绝对值大于2）
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg) #查看筛选后的总结信息
##这里就是R900/Y58S
write.csv(deg, file = "P_R900-vs-Y58S_diff.csv") #将差异表达显著的结果输出到csv文件



##-------- Y58S-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("Y58S_1P") |contains("Y58S_5P") |contains("Y900_1P") |contains("Y900_5P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("Y58S","Y900"),times=c(6,6))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "P_Y58S-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "P_Y58S-vs-Y900_diff.csv") #Y58S/Y900


##-------- R900-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_1P") |contains("R900_5P") |contains("Y900_1P") |contains("Y900_5P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y900"),times=c(5,6))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "P_R900-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "P_R900-vs-Y900_diff.csv") #R900/Y900



#################### Tissue L ##########################################################

##-------- R900-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_L") |contains("Y900_L"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y900"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
nrow(dds)
dds <- dds[ rowSums(counts(dds))>1, ] ##将所有样本基因表达量之和小于1的基因过滤掉
nrow(dds)
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "L_R900-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "L_R900-vs-Y900_diff.csv") 

##-------- Y58S-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("Y58S_L") |contains("Y900_L"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("Y58S","Y900"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "L_Y58S-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "L_Y58S-vs-Y900_diff.csv") 

##-------- R900-vs-Y58S
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_L") |contains("Y58S_L"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y58S"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "L_R900-vs-Y58S_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "L_R900-vs-Y58S_diff.csv") 



#################### Tissue S ##########################################################

##-------- R900-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_S") |contains("Y900_S"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y900"),times=c(2,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "S_R900-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "S_R900-vs-Y900_diff.csv") 

##-------- Y58S-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("Y58S_S") |contains("Y900_S"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("Y58S","Y900"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "S_Y58S-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "S_Y58S-vs-Y900_diff.csv") 

##-------- R900-vs-Y58S
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_S") |contains("Y58S_S"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y58S"),times=c(2,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "S_R900-vs-Y58S_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "S_R900-vs-Y58S_diff.csv") 




#################### Tissue 1P ##########################################################

##-------- R900-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_1P") |contains("Y900_1P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y900"),times=c(2,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "1P_R900-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "1P_R900-vs-Y900_diff.csv") 

##-------- Y58S-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("Y58S_1P") |contains("Y900_1P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("Y58S","Y900"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "1P_Y58S-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "1P_Y58S-vs-Y900_diff.csv") 

##-------- R900-vs-Y58S
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_1P") |contains("Y58S_1P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y58S"),times=c(2,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "1P_R900-vs-Y58S_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "1P_R900-vs-Y58S_diff.csv") 



#################### Tissue 5P ##########################################################

##-------- R900-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_5P") |contains("Y900_5P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y900"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "5P_R900-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "5P_R900-vs-Y900_diff.csv") 

##-------- Y58S-vs-Y900
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("Y58S_5P") |contains("Y900_5P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("Y58S","Y900"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "5P_Y58S-vs-Y900_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "5P_Y58S-vs-Y900_diff.csv") 

##-------- R900-vs-Y58S
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("R900_5P") |contains("Y58S_5P"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("R900","Y58S"),times=c(3,3))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "5P_R900-vs-Y58S_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "5P_R900-vs-Y58S_diff.csv") 



# 不同组织比较 ------------------------------------------------------------------

##-------- P-vs-L
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("P") |contains("L"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("P","L"),times=c(17,9))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "P-vs-L_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "P-vs-L_diff.csv") 


##-------- P-vs-S
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("P") |contains("_S"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("P","S"),times=c(17,8))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "P-vs-S_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "P-vs-S_diff.csv") 


##-------- L-vs-S
colnames(newdata3)
CountMatrix1=newdata3 %>% select(contains("L") |contains("_S"))
CountMatrix1<-CountMatrix1[which(rowSums(CountMatrix1) > 0),]
colnames(CountMatrix1)
ColumnData<- data.frame(row.names=colnames(CountMatrix1),samName=colnames(CountMatrix1), condition=rep(c("L","S"),times=c(9,8))) 
dds<-DESeqDataSetFromMatrix(countData = CountMatrix1, colData = ColumnData, design = ~ condition)
dds<-DESeq(dds) 
dds <- dds[ rowSums(counts(dds))>1, ] 
res<-results(dds)  
res<- res[order(res$padj),]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)),by="row.names",sort=FALSE)
write.csv(resdata,file = "L-vs-S_all.csv",row.names = F)
deg <- subset(res, padj <= 0.05 & abs(log2FoldChange) >= 1) 
summary(deg)
write.csv(deg, file = "L-vs-S_diff.csv") 



