# conda activate gatk4
#3.去除重复
for i in $(ls *.marked.bam)
do
i=${i/.marked.bam/}
echo "gatk MarkDuplicates --INPUT ${i}.marked.bam --OUTPUT ${i}.dup.bam --CREATE_INDEX true --VALIDATION_STRINGENCY SILENT --METRICS_FILE ${i}.dup.metrics" >>rmdup_${i}.sh
done
