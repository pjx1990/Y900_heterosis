for i in `seq 565 572`;do
echo "/ifs1/Software/biosoft/samtools/samtools view -bS R900_${i}.sam > R900_${i}.bam ">${i}.sh
echo "/ifs1/Software/biosoft/samtools/samtools sort R900_${i}.bam -@ 4 -o R900_${i}.sorted.bam ">>${i}.sh
echo "/ifs1/Software/biosoft/samtools/samtools flagstat R900_${i}.sorted.bam >R900_${i}.flagstat.txt ">>${i}.sh
done
