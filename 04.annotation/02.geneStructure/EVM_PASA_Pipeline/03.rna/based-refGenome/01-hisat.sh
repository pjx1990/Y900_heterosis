#/ifs1/Software/biosoft/hisat2-2.1.0/hisat2 --dta -p 5 -x index/chi_masked -1 /ifs1/User/pengjx/project/rawdata/RNA_cleanData/YR900-1P-1/AE32512896-582_1.fq.gz -2 /ifs1/User/pengjx/project/rawdata/RNA_cleanData/YR900-1P-1/AE32512896-582_2.fq.gz | samtools sort -@ 5 > rna-seq/AE32512896-582.bam &
cat sample.info |while read sample fq1 fq2;do
#echo $sample $fq1 $fq2
/ifs1/Software/biosoft/hisat2-2.1.0/hisat2 --dta -p 3 -x index/chi_masked -1 $fq1 -2 $fq2 | /ifs1/Software/biosoft/samtools/samtools sort -@ 3 > rna-seq/${sample}.bam &
done
