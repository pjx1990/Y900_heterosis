ln -s /ifs1/User/pengjx/database/homology/all_ref/R900.fa genome.fa

echo -----------find ltr start:`date`-------------
# find LTR
#/ifs1/User/pengjx/biosoft/LTR_Finder/source/ltr_finder genome.fa >genome.finder.scn
~/biosoft/anaconda3/bin/gt suffixerator -db genome.fa -tis -suf -lcp -des -ssp -sds -dna
~/biosoft/anaconda3/bin/gt ltrharvest -index genome.fa -minlenltr 100 -maxlenltr 7000 -mintsd 4 -maxtsd 6 -motif TGCA -motifmis 1 -similar 85 -vic 10 -seed 20 -seqids yes > genome.fa.harvest.scn

perl /ifs1/User/pengjx/project/Rice/02.evaluate/LAI/LTR_FINDER_parallel-master/LTR_FINDER_parallel -seq genome.fa -threads 25 -harvest_out -size 1000000 -time 300 

cat genome.fa.harvest.scn genome.fa.finder.combine.scn > genome.fa.rawLTR.scn

echo -----------find ltr end:`date`-------------
# get LTR-RT
/ifs1/User/pengjx/biosoft/anaconda3/bin/LTR_retriever -threads 25 -genome genome.fa -inharvest genome.fa.rawLTR.scn 

echo -----------ltr-rt end:`date`-------------
# get LAI
/ifs1/User/pengjx/biosoft/anaconda3/bin/LAI -t 25 -genome genome.fa -intact genome.fa.pass.list -all genome.fa.out
echo -----------lai end:`date`-------------
