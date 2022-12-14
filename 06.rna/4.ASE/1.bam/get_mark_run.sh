#bam文件添加标签
#conda activate gatk4
# ln -s /ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/* .
for i in $(ls *.bam)
do
   i=${i/.bam/}
   echo $i
#   java -jar /opt/software/basic-software-bin/bin/picard.jar \
    echo "picard AddOrReplaceReadGroups I=${i}.bam O=${i}.marked.bam SO=coordinate RGID=${i} RGLB=mRNA RGPL=MGI RGPU=MGI2000 RGSM=${i}" >>${i}.sh
#       SO=coordinate RGID=${i} RGLB=mRNA RGPL=illumina RGPU=HiSeq2500 RGSM=${i}
done
