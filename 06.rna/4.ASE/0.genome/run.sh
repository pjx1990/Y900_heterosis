# conda activate gatk4
gatk CreateSequenceDictionary -R genome.fa
samtools faidx genome.fa 
awk -v FS="\t" -v OFS="\t" '{print $1 FS "0" FS $2}' genome.fa.fai >genome.bed
gatk BedToIntervalList -I genome.bed -O genome.interval.list -SD genome.dict 
