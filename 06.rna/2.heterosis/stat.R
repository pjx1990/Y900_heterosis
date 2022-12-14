######################
### 统计全部杂优模式结果
#####################
rm(list = ls())
library(tidyverse)
setwd("F:\\杂优中心\\杂种优势表达模式\\DESeq2\\stringtieNonovel\\杂优模式")

p1 <- read.table("1P/tisse_1P_heterosis_pattern_stat.txt",header = T)
p5 <- read.table("5P/tisse_5P_heterosis_pattern_stat.txt",header = T)
L <- read.table("L/tisse_L_heterosis_pattern_stat.txt",header = T)
S <- read.table("S/tisse_S_heterosis_pattern_stat.txt",header = T)
p <- read.table("P/tisse_P_heterosis_pattern_stat.txt",header = T)

# all union (on linux stat)
## P分为1P和5P
union_L_S_1P_5P <- data.frame(DGpp=10393,
                      DGhp=9391,
                      Y900.R900=6784,
                      Y900.Y58S=4904,
                      DGhpu=5302,
                      DGo=876,
                      PDO=822,
                      DO=5302,
                      ODO=850,
                      H2P=357,
                      CHP=3596,
                      B2P=822,
                      CLP=2046,
                      L2P=496,
                      P1=343,
                      P2=10,
                      P3=1416,
                      P4=434,
                      P5=1450,
                      P6=11,
                      P7=457,
                      P8=30,
                      P9=622,
                      P10=389,
                      P11=2207,
                      P12=5,
                      Other=9061)
union_L_S_1P_5P

## P不分1P和5P
union_L_S_P <- data.frame(DGpp=9691,
                          DGhp=8543,
                          Y900.R900=5750,
                          Y900.Y58S=4819,
                          DGhpu=4750,
                          DGo=852,
                          PDO=803,
                          DO=4750,
                          ODO=749,
                          H2P=341,
                          CHP=3381,
                          B2P=803,
                          CLP=1582,
                          L2P=410,
                          P1=326,
                          P2=10,
                          P3=1418,
                          P4=418,
                          P5=999,
                          P6=6,
                          P7=375,
                          P8=30,
                          P9=591,
                          P10=386,
                          P11=1985,
                          P12=5,
                          Other=8080)
union_L_S_P

all_stat <- do.call(rbind,list(S,L,p1,p5,p,union_L_S_1P_5P,union_L_S_P))
all_stat

all_stat2 <- cbind(data.frame(Tissue=c("Stem","Leaf","Panicle_1P","Panicle_5P","Panicle","Total_S_L_1P_5P","Total_S_L_P")),all_stat)
all_stat2
write.table(all_stat2,"all_heterosis_pattern_stat.txt",col.names = T,row.names = F,quote = F,sep = "\t")
