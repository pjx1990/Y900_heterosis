##############################
### Syri QTN mapping
###################################

rm(list = ls())
#setwd("C:/Users/Jesse/Desktop/RiceGenome/QTNsites/syri")
library(dplyr)
args=commandArgs(T)
#args[1]="Y58S.vcf"
#args[2]="R900.vcf"
if(length(args)<1){stop("Error,input at least one vcf file!")}

qtn <- read.delim("QTNsites.txt",header = T,sep = "\t")
qtn=qtn[!duplicated(qtn),]
#data <- read.table(args[1])
#qtn$Pos_7.0 <- as.character(qtn$Pos_7.0)
#data$V2 <- as.character(data$V2)
#
#variant <- left_join(qtn,data[1:3],by=c("Chr"="V1","Pos_7.0"="V2"))
#colnames(variant)[10] <- c("Type")

allvcf <- NULL
for(i in 1:length(args)){
  print(args[i])
  data <- read.table(args[i])
  data=data[!duplicated(data[1:2]),]
  qtn$Pos_7.0 <- as.character(qtn$Pos_7.0)
  data$V2 <- as.character(data$V2)
  variant <- left_join(qtn,data[1:3],by=c("Chr"="V1","Pos_7.0"="V2"))
  colnames(variant)[10] <- gsub(".vcf","",args[i])
  write.csv(variant,paste0(colnames(variant)[10],"_QTN_mapped.csv"),col.names = F,row.names = F)
allvcf[[i]] <- variant[!duplicated(variant[1:9]),]
#  allvcf[[i]] <- variant[!duplicated(variant),]
}

allout <- cbind(allvcf[[1]],
                allvcf[[2]][10],
                allvcf[[3]][10],
                allvcf[[4]][10],
                allvcf[[5]][10],
                allvcf[[6]][10],
                allvcf[[7]][10],
                allvcf[[8]][10],
                allvcf[[9]][10])

write.csv(allout,"QTN_mapped_syri.csv",col.names = F,row.names = F)
