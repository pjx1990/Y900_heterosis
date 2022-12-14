# conda activate braker2
braker.pl --cores 48 --species=58S_orthodb2 \
         --genome=/ifs1/User/pengjx/project/Rice/06.annotation/repeat/combined/58S/softmask/58S.genome.fa.masked \
         --softmasking \
         --bam=AE10636551-507.bam,AE42535600-505.bam,AE65607196-530.bam,AE10636551-508.bam,AE42535600-506.bam,AE65607196-531.bam,AE29325480-566.bam,AE43904599-589.bam,AE66359982-557.bam,AE29325480-567.bam,AE43904599-590.bam,AE66359982-559.bam,AE32512896-582.bam,AE60586113-587.bam,AE70424812-560.bam,AE32512896-583.bam,AE60586113-588.bam,AE70424812-565.bam,AE41406422-509.bam,AE63027154-539.bam,AE79319221-532.bam,AE41406422-510.bam,AE63027154-540.bam,AE79319221-538.bam \
         --hints=/ifs1/User/pengjx/project/Rice/06.annotation/braker2/plants/58S/prothint_augustus.gff \
         --etpmode \
         --gff3 
#         --prg=gth \


#使用Orthodb蛋白
