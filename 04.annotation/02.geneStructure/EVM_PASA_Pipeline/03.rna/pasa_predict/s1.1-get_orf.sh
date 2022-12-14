## 预测ORF
/ifs1/User/pengjx/biosoft/anaconda3/envs/pasa//opt/pasa-2.4.1/scripts/pasa_asmbls_to_training_set.dbi \
        --pasa_transcripts_fasta mydb.sqlite.assemblies.fasta \
        --pasa_transcripts_gff3 mydb.sqlite.pasa_assemblies.gff3

##结果：
#mydb.sqlite.assemblies.fasta.transdecoder.cds/pep/gff3/bed 不在基因组上，但是根据转录本信息，有可能是编码区的结果
#mydb.sqlite.assemblies.fasta.transdecoder.genome.bed/gff3: 对应基因组序列的基因模型
