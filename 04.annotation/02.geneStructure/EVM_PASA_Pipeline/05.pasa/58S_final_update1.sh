#conda activate pasa
/ifs1/User/pengjx/biosoft/anaconda3/envs/pasa/opt/pasa-2.4.1/Launch_PASA_pipeline.pl \
        -c annotationCompare.config \
        -A -g 58S.genome.fa \
        -t transcript.fasta.clean \
        -T -u transcript.fasta \
        --CPU 30 \
        -L --annots /ifs1/User/pengjx/project/Rice/06.annotation/EVM/58S-final/no_pasa/OsY58Sg_nopasa.gff3
#-L --annots evm.all.gff3

## config中数据库名称必须和alignAssembly.config一样
## evm.all.gff3 后缀必须为gff3或gtf
