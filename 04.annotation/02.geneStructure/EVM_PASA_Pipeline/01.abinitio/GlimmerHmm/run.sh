#/ifs1/User/pengjx/biosoft/GlimmerHMM/bin/glimmerhmm_linux_x86_64 ./R900.genome.masked.fa -d /ifs1/User/pengjx/biosoft/GlimmerHMM/trained_dir/rice -g -f -n 1 -o R900.glimmerhmm.gff3

seqkit split -i R900.genome.masked.fa
mkdir glimmerhmm.gff3.split
ls R900.genome.masked.fa.split/*.fa |while read i;do
fa=`echo $i |sed 's#.*/##g'`
echo $fa
/ifs1/User/pengjx/biosoft/GlimmerHMM/bin/glimmerhmm_linux_x86_64 $i -d /ifs1/User/pengjx/biosoft/GlimmerHMM/trained_dir/rice -g -f -n 1 -o glimmerhmm.gff3.split/${fa}.gff3
sed -i '1,2d' glimmerhmm.gff3.split/${fa}.gff3
done
cat glimmerhmm.gff3.split/*.gff3 >glimmerhmm_all.gff3
