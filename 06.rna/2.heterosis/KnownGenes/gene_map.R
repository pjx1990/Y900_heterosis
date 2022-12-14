args=commandArgs(T)
name=gsub(".txt","",args[1])
x=read.table(args[1],header=F)
colnames(x)="MSU"
y=read.delim("../tidy_funGenes/all_QTN_funRiceGenes_split.txt",header=T,sep='\t')
z=dplyr::left_join(x,y,by=c("MSU"))
write.csv(z,paste0(name,"_info.csv"),row.names=F)
