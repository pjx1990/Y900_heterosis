#/data/software/soft/bwa-0.7.17/bwa index assembly.fasta 
#sh bwaGvcf.sh refL1 /backup/NDES00271_L1_1_clean.rd.fq.gz /backup/NDES00271_L1_2_clean.rd.fq.gz &
#sh bwaGvcf.sh refL2 /backup/NDES00271_L2_1_clean.rd.fq.gz /backup/NDES00271_L2_2_clean.rd.fq.gz &

#nohup sh bwaGvcf.sh ref573 PADsmpDAAAB-573_1.fq.gz PADsmpDAAAB-573_2.fq.gz &
#nohup sh bwaGvcf.sh ref574 PADsmpDAAAB-574_1.fq.gz PADsmpDAAAB-574_2.fq.gz &
#nohup sh bwaGvcf.sh ref575 PADsmpDAAAB-575_1.fq.gz PADsmpDAAAB-575_2.fq.gz &
#nohup sh bwaGvcf.sh ref576 PADsmpDAAAB-576_1.fq.gz PADsmpDAAAB-576_2.fq.gz &
#nohup sh bwaGvcf.sh ref577 PADsmpDAAAB-577_1.fq.gz PADsmpDAAAB-577_2.fq.gz &
#nohup sh bwaGvcf.sh ref578 PADsmpDAAAB-578_1.fq.gz PADsmpDAAAB-578_2.fq.gz &
#nohup sh bwaGvcf.sh ref579 PADsmpDAAAB-579_1.fq.gz PADsmpDAAAB-579_2.fq.gz &
#nohup sh bwaGvcf.sh ref580 PADsmpDAAAB-580_1.fq.gz PADsmpDAAAB-580_2.fq.gz &
##wait
/ifs1/Software/biosoft/samtools/samtools merge -@20 ref.rmdup.bam ref565.rmdup.bam ref566.rmdup.bam ref567.rmdup.bam ref568.rmdup.bam ref569.rmdup.bam ref570.rmdup.bam ref571.rmdup.bam ref572.rmdup.bam

/ifs1/Software/biosoft/samtools/samtools index ref.rmdup.bam
/ifs1/Software/biosoft/samtools/samtools flagstat -@8 ref.rmdup.bam > aln.info 
MOSDEPTH_PRECISION=5 mosdepth -t 16 ref ref.rmdup.bam
##python depth.plot.py --input depth.hist.txt --output ref.depth --sample ref
##java -Xmx450G -jar /data/software/soft/pilon-1.24.jar --genome assembly.fasta --bam ref.rmdup.bam --output pilon1x --outdir pilon1x --changes --vcf --diploid --threads 8


#plot depth
grep '^total' ref.mosdepth.global.dist.txt |tac > depth.txt
source activate py2
python cal.py > depth.hist.txt
python depth.plot.py --input depth.hist.txt --output ref.depth --sample R900

