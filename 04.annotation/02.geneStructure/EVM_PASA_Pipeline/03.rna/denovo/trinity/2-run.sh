#conda activate rna
Trinity --seqType fq --left ../../data/R900_1.fq.gz --right ../../data/R900_2.fq.gz --CPU 50 --max_memory 125G
