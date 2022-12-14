#4.切除内含子区域的reads
#conda activate gatk4
for i in $(ls *.dup.bam)
do
i=${i/.dup.bam/}
echo "gatk SplitNCigarReads -R ../0.genome/genome.fa -I ${i}.dup.bam -O ${i}.split.bam">>split_${i}.sh
done

