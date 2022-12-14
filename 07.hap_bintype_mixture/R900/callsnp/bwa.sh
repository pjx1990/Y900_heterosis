#conda activate 3k
#ln -s /ifs1/User/pengjx/database/ref_genome/MSU_Chr.fa MSU7.fasta 
#bwa index MSU7.fasta
#for i in $(seq 565 572) ;do 
i=572
bwa mem -t 10 -k 19 -M -R "@RG\tID:R900\tLB:R900\tSM:R900"  MSU7.fasta /ifs1/User/pengjx/project/rawdata/Genome_CleanData/NGS/Clean/R900/PADsmpDAAAA-${i}_1.fq.gz  /ifs1/User/pengjx/project/rawdata/Genome_CleanData/NGS/Clean/R900/PADsmpDAAAA-${i}_2.fq.gz | /ifs1/User/pengjx/biosoft/anaconda3/envs/samtools/bin/samtools view -b -t MSU7.fasta - >R900_${i}.bam  
#done
/ifs1/User/pengjx/biosoft/anaconda3/envs/samtools/bin/samtools sort -@ 10 R900_${i}.bam -o R900_${i}.sorted.bam
rm -f R900_${i}.bam

picard MarkDuplicates INPUT=R900_${i}.sorted.bam MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=800 TMP_DIR=./temp OUTPUT=R900_${i}.rmdup.bam METRICS_FILE=R900_${i}.rmdup.metrics

/ifs1/User/pengjx/biosoft/anaconda3/envs/samtools/bin/samtools index R900_${i}.rmdup.bam


