#conda activate pasa
#cp /ifs1/User/pengjx/biosoft/anaconda3/envs/pasa/opt/pasa-2.4.1/pasa_conf/pasa.alignAssembly.Template.txt alignAssembly.config
#ln -s /ifs1/User/pengjx/project/Rice/03.rna/trinity-genome-guieded/58S/trinity_out_dir/Trinity-GG.fasta .
#ln -s /ifs1/User/pengjx/project/Rice/03.rna/trinity/58S/trinity_out_dir/Trinity.fasta .
##cat Trinity.fasta  Trinity-GG.fasta >transcript.fasta
#cat Trinity-GG.fasta >transcript.fasta

##过滤
#/ifs1/User/pengjx/biosoft/anaconda3/envs/pasa/opt/pasa-2.4.1/bin/seqclean transcript.fasta -v /ifs1/User/pengjx/project/Rice/06.annotation/PASA/UniVec/UniVec

echo ----------`date`-----------
## 比对
/ifs1/User/pengjx/biosoft/anaconda3/envs/pasa/opt/pasa-2.4.1/Launch_PASA_pipeline.pl \
        -c alignAssembly.config\
        -C -R  \
        -g 58S.genome.fa \
        -t transcript.fasta.clean \
        -T -u transcript.fasta \
        --ALIGNERS gmap,blat \
        --CPU 50
