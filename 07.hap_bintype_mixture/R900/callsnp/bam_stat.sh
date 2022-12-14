for i in `seq 565 572`;do
echo $i
#for i in `ls R900*.sam`;do
#/ifs1/Software/biosoft/samtools/samtools view -bS $i >$i.bam
#/ifs1/Software/biosoft/samtools/samtools sort $i.bam -o $i.sorted.bam
#/ifs1/Software/biosoft/samtools/samtools flagstat $i.sorted.bam >$i.flagstat.txt
/ifs1/User/pengjx/biosoft/anaconda3/envs/samtools/bin/samtools sort R900_${i}.bam -o R900_${i}.sorted.bam
/ifs1/User/pengjx/biosoft/anaconda3/envs/samtools/bin/samtools flagstat R900_${i}.sorted.bam > R900_${i}.flagstat.txt
done
