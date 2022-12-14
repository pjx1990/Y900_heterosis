for i in `ls R900*.sam`;do
/ifs1/Software/biosoft/samtools/samtools view -bS $i >$i.bam
/ifs1/Software/biosoft/samtools/samtools sort $i.bam -o $i.sorted.bam
/ifs1/Software/biosoft/samtools/samtools flagstat $i.sorted.bam >$i.flagstat.txt
done
