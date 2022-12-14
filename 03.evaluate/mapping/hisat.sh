mkdir index
/ifs1/Software/biosoft/hisat2-2.1.0/hisat2-build -p 20 R900.fasta index/R900

for i in AE11478291-520 AE11478291-521 AE32512896-582 AE32512896-583 AE00664796-501 AE00664796-502
do
echo $i
hisat2 -p 20 -x index/R900 -1 ../../${i}_1.fq.gz -2 ../../${i}_2.fq.gz -S ${i}.sam

/ifs1/Software/biosoft/samtools/samtools flagstat -@ 10 ${i}.sam >$i.flagstat.txt
#/ifs1/Software/biosoft/samtools/samtools depth ${i}.sam >$i.depth.txt
rm ${i}.sam
done
