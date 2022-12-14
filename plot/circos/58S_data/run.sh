#VCF_get_variants_density_for_circos.pl /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/SyRI/syri.vcf genome.fasta >variant_density.histogram_for_circos.txt

perl -lane 'if(/^#/){print "$_"} elsif($F[2] =~ /^SNP/){print "$_"}' /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/SyRI/syri.vcf >snp.vcf
perl -lane 'if(/^#/){print "$_"} elsif($F[2] =~ /^INS/ | $F[2] =~ /^DEL/){print "$_"}' /ifs1/User/pengjx/project/Rice/07.compare/two-assembly/SyRI/syri.vcf >indel.vcf

VCF_get_variants_density_for_circos.pl snp.vcf genome.fasta 100000 >snp_density.histogram_for_circos.txt
VCF_get_variants_density_for_circos.pl indel.vcf genome.fasta 100000 >indel_density.histogram_for_circos.txt
