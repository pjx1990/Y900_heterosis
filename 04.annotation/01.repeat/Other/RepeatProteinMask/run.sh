#/ifs1/Software/biosoft/RepeatMasker/RepeatProteinMask -engine ncbi 58S.genome.fa
#/ifs1/User/pengjx/biosoft/anaconda3/envs/repeat/share/RepeatMasker/RepeatProteinMask -engine ncbi R900.genome.fa
~/biosoft/anaconda3/envs/repeat/bin/RepeatProteinMask -engine ncbi R900.genome.fa
perl repeatproteinmask2gff.pl R900.genome.fa.annot protein.gff
