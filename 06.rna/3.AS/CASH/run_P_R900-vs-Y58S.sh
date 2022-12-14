mkdir R900-Y58S
java -jar -Xmx20g /ifs1/User/pengjx/biosoft/cash_v2.2.1/cash.jar \
         --Case:R900 /ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/R900-1P-1.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/R900-1P-2.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/R900-1P-3.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/R900-5P-1.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/R900-5P-2.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/R900-5P-3.bam \
         --Control:Y58S /ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/Y58S-1P-1.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/Y58S-1P-2.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/Y58S-1P-3.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/Y58S-5P-1.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/Y58S-5P-2.bam,/ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/01-hisat2/bam/Y58S-5P-3.bam \
         --GTF /ifs1/User/pengjx/database/homology/MSU7/msu7.gtf \
         --Output R900-Y58S
