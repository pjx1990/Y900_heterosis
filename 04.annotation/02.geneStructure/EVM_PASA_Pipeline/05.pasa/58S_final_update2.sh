#conda activate pasa
/ifs1/User/pengjx/biosoft/anaconda3/envs/pasa/opt/pasa-2.4.1/Launch_PASA_pipeline.pl \
        -c annotationCompare.config \
        -A -g 58S.genome.fa \
        -t transcript.fasta.clean \
        -T -u transcript.fasta \
        --CPU 30 \
        -L --annots mydb.sqlite.gene_structures_post_PASA_updates.759797.gff3
#-L --annots evm.all.gff3

## config中数据库名称必须和alignAssembly.config一样
## evm.all.gff3 后缀必须为gff3或gtf
