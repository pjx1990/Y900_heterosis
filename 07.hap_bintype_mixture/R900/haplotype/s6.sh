#mkdir NAF_score
#perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/classify_sample_haplotype_score.pl R900.haplotype 3K-HAP.haplotype.NAF_score NAF_score/

perl /ifs1/User/pengjx/project/Rice/09.indica_japonica_mix/3KRG-HAP-master/scripts/scan_haplotype_stdratio.pl NAF_score/R900.hapratio window.10k.bin.bed sample.bin_NAF
