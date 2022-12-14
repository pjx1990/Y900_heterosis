#################
## 杂种优势表达模式分类
## tissus P(1P+5P)
#################
rm(list = ls())
library(tidyverse)


# input data --------------------------------------------------------------


setwd("F:\\杂优中心\\杂种优势表达模式\\DESeq2\\stringtieNonovel\\杂优模式\\P")

d1 <- read.csv("../../DESeq2/readscount大于1过滤/P_R900-vs-Y58S_diff.csv",header = T)
d2 <- read.csv("../../DESeq2/readscount大于1过滤/P_R900-vs-Y900_diff.csv",header = T)
d3 <- read.csv("../../DESeq2/readscount大于1过滤/P_Y58S-vs-Y900_diff.csv",header = T)

# 父母本及其杂交种差异基因overlap -----------------------------------------------------

gplots::venn(data=list(d1$X,d2$X,d3$X),names = c("R900-VS-Y58S","R900-VS-Y900","Y58S-VS-Y900"))

library(VennDiagram)
venn.plot <- venn.diagram(
  x = list(d1$X,d2$X,d3$X),
  filename = NULL,
  col = "transparent",
  fill = c("red", "blue", "green"),
  alpha = 0.5,
  label.col = c("darkred", "white", "darkblue", "white",
                "white", "white", "darkgreen"),
  cex = 2.5,
  fontfamily = "serif",
  fontface = "bold",
  cat.default.pos = "text",
  cat.col = c("darkred", "darkblue", "darkgreen"),
  cat.cex = 2.5,
  cat.fontfamily = "serif",
  cat.dist = c(0.06, 0.06, 0.03),
  category = c("R900-VS-Y58S","R900-VS-Y900","Y58S-VS-Y900"),
  cat.pos = 0
);
grid.draw(venn.plot);
grid.newpage();


# 表达模式 --------------------------------------------------------------------

names(d1)[-1] <- paste0("R900-VS-Y58S_",names(d1)[-1])
names(d1)
names(d2)[-1] <- paste0("R900-VS-Y900_",names(d2)[-1])
names(d3)[-1] <- paste0("Y58S-VS-Y900_",names(d3)[-1])

alldiff <- Reduce(function(x,y)full_join(x,y,by="X"),list(d1,d2,d3))

data_a <- alldiff %>% select(contains("log2FoldChange") |contains(("padj")))
colnames(data_a)

# i=1
p1=p2=p3=p4=p5=p6=p7=p8=p9=p10=p11=p12=other=NULL
##转录组后者比前者
for(i in 1:nrow(data_a)){
  print(paste0("currently line is: ",i))
  # pattern 1：即58S和R900无差异，杂交种显著高
  if(data_a[i,2]>0 &  
     data_a[i,3]>0 & 
     complete.cases(data_a[i,5]) & 
     complete.cases(data_a[i,6]) & 
     is.na(data_a[i,4])){
    p1=c(p1,i)
  #pattern 2：三者都显著差异，且Y900>R900>Y58S
  }else if(data_a[i,1]<0 &
           data_a[i,2]>0 &
           data_a[i,3]>0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           complete.cases(data_a[i,6]) ){
    p2=c(p2,i)
  #pattern 3 
  }else if(data_a[i,1]<0 &
           data_a[i,3]>0 &
           complete.cases(data_a[i,4]) &
           is.na(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p3=c(p3,i)
    #pattern 4：三者都显著差异，且R900>Y900>Y58S
  }else if(data_a[i,1]<0 &
           data_a[i,2]<0 &
           data_a[i,3]>0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p4=c(p4,i)
    #pattern 5
  }else if(data_a[i,1]<0 &
           data_a[i,2]<0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           is.na(data_a[i,6])){
    p5=c(p5,i)
    #pattern 6
  }else if(data_a[i,1]<0 &
           data_a[i,2]<0 &
           data_a[i,3]<0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p6=c(p6,i)
    #pattern 7
  }else if( data_a[i,2]<0 &
           data_a[i,3]<0 &
           is.na(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p7=c(p7,i)
    #pattern 8
  }else if(data_a[i,1]>0 &
           data_a[i,2]<0 &
           data_a[i,3]<0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p8=c(p8,i)
    #pattern 9
  }else if(data_a[i,1]>0 &
           data_a[i,3]<0 &
           complete.cases(data_a[i,4]) &
           is.na(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p9=c(p9,i)
    #pattern 10
  }else if(data_a[i,1]>0 &
           data_a[i,2]>0 &
           data_a[i,3]<0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p10=c(p10,i)
    #pattern 11
  }else if(data_a[i,1]>0 &
           data_a[i,2]>0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           is.na(data_a[i,6])){
    p11=c(p11,i)
    #pattern 12
  }else if(data_a[i,1]>0 &
           data_a[i,2]>0 &
           data_a[i,3]>0 &
           complete.cases(data_a[i,4]) &
           complete.cases(data_a[i,5]) &
           complete.cases(data_a[i,6])){
    p12=c(p12,i)
  }else{
    other=c(other,i)
  }

}
p1
p2

length(p1)+length(p2)+length(p3)+length(p4)+length(p5)+
  length(p6)+length(p7)+length(p8)+length(p9)+length(p10)+
  length(p11)+length(p12) #+length(other)

data_a[p2,]
p1_data <- alldiff[p1,]

##至少要有两组差异有效还好比较，而other只有一组有效值，其他两组比较都是NA，因此这部分不能用于杂种优势数目
other_data <- alldiff[other,]


## additive/partial dominant
ad <- c(alldiff[p4,]$X,alldiff[p10,]$X)

## dominat
dom <- c(alldiff[p11,]$X,alldiff[p5,]$X,alldiff[p3,]$X,alldiff[p9,]$X)

## over-dominant
over_dom <- c(alldiff[p12,]$X,alldiff[p2,]$X,alldiff[p6,]$X,alldiff[p8,]$X,alldiff[p1,]$X,alldiff[p7,]$X)
# length(unique(c(ad,dom,over_dom)))
# length(unique(c(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12)))


## DGhp=DG between the hybrid and parent
DGhp=unique(c(d2$X,d3$X))
## DGpp=DG between both parents
DGpp=d1$X

`Y900/R900`=d2$X
`Y900/Y58S`=d3$X

## DGhpu=denotes the unique portion of DGhp
##Y900和两个亲本之一有差异
p1_12 <- alldiff[-other,]
colnames(p1_12)
idx=apply(p1_12,1,function(x){sum(is.na(x[c(13,19)]))==1})
DGhpu=p1_12[idx,]$X

## DGo=denotes the overlap between DGpp and DGhp
##三组材料都要有差异
DGo=na.omit(alldiff)$X

## H2P, higher than both parents
H2P=c(alldiff[p1,]$X,alldiff[p2,]$X,alldiff[p12,]$X)
## CHP, close to higher parent,
CHP=c(alldiff[p3,]$X,alldiff[p11,]$X)
## B2P, between both parents,
B2P=c(alldiff[p4,]$X,alldiff[p10,]$X)
## CLP,close to lower parent
CLP=c(alldiff[p5,]$X,alldiff[p9,]$X)
## L2P, lower than both parents
L2P=c(alldiff[p6,]$X,alldiff[p7,]$X,alldiff[p8,]$X)

length(unique(c(H2P,CHP,B2P,CLP,L2P)))


# tidy result -------------------------------------------------------------

all_res <- data.frame(DGpp=length(DGpp),
                      DGhp=length(DGhp),
                      `Y900/R900`=length(d2$X),
                      `Y900/Y58S`=length(d3$X),
                      DGhpu=length(DGhpu),
                      DGo=length(DGo),
                      PDO=length(ad), #部分显性
                      DO=length(dom), #显性
                      ODO=length(over_dom), #超显性
                      H2P=length(H2P),
                      CHP=length(CHP),
                      B2P=length(B2P),
                      CLP=length(CLP),
                      L2P=length(L2P),
                      P1=length(p1),
                      P2=length(p2),
                      P3=length(p3),
                      P4=length(p4),
                      P5=length(p5),
                      P6=length(p6),
                      P7=length(p7),
                      P8=length(p8),
                      P9=length(p9),
                      P10=length(p10),
                      P11=length(p11),
                      P12=length(p12),
                      Other=length(other)
                      )
all_res
write.table(all_res,"tisse_P_heterosis_pattern_stat.txt",col.names = T,row.names = F,sep = "\t",quote = F)



# output gene -------------------------------------------------------------

colnames(all_res)

for(i in 1:12){
  # i=1
  a=eval(parse(text = paste0("p",i)))
  write.table(alldiff[a,]$X,paste0("P",i,".txt"),row.names = F,col.names = F,quote = F)
}
write.table(alldiff[other,]$X,"Other.txt",row.names = F,col.names = F,quote = F)

write.table(ad,"PDO.txt",row.names = F,col.names = F,quote = F)
write.table(dom,"DO.txt",row.names = F,col.names = F,quote = F)
write.table(over_dom,"ODO.txt",row.names = F,col.names = F,quote = F)

typen <- c("DGpp","DGhp","DGhpu","DGo","H2P","CHP","B2P","CLP","L2P")
for(i in 1:length(typen)){
  # i=1
  a=eval(parse(text =typen[i]))
  write.table(a,paste0(typen[i],".txt"),row.names = F,col.names = F,quote = F)
}

write.table(`Y900/Y58S`,"Y900.Y58S.txt",row.names = F,col.names = F,quote = F)
write.table(`Y900/R900`,"Y900.R900.txt",row.names = F,col.names = F,quote = F)

