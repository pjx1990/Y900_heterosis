genome_total=398235726
CMnumber=`grep "ACC" /ifs1/User/pengjx/database/Rfam/Rfam.cm|wc -l`
Z=`echo $genome_total*2*$CMnumber/1000000 |bc`
#echo $Z

cmscan -Z $Z --cut_ga --rfam --nohmmonly --tblout 58S.tblout --fmt 2 --cpu 30 --clanin /ifs1/User/pengjx/database/Rfam/Rfam.clanin /ifs1/User/pengjx/database/Rfam/Rfam.cm 58S.genome.fa > 58S.cmscan
perl infernal-tblout2gff.pl --cmscan --fmt2 58S.tblout >Y58S.infernal.ncRNA.gff3
