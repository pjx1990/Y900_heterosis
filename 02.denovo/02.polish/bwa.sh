#for i in `seq 565 572`;do
#echo "bwa mem -t 10 index/R900 /ifs1/User/pengjx/project/rawdata/NGS_cleanData_backup/R900/run-*/PADsmpDAAAA-${i}_1.fq.gz /ifs1/User/pengjx/project/rawdata/NGS_cleanData_backup/R900/run-*/PADsmpDAAAA-${i}_2.fq.gz | /ifs1/Software/biosoft/samtools/samtools sort -@ 10 -O bam -o R900_${i}.bam ">${i}.sh
#done

##merge bam
/ifs1/Software/biosoft/samtools/samtools merge -@ 20 R900.bam R900_*.bam

## build index
/ifs1/Software/biosoft/samtools/samtools index -@ 10 R900.bam
