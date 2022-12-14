#conda activate rna
Trinity --genome_guided_bam /ifs1/User/pengjx/project/Rice/03.rna/hisat2/R900/rna-seq/merged.bam \
            --max_memory 300G \
            --genome_guided_max_intron 10000 \
            --CPU 50
