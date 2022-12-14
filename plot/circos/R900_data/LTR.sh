##准备LAI的文件（windowssize为300kb）
cat genome.fa.out.LAI|cut -f 1,2,3,7 |sed '1,2d' >LAI_num.txt
###完整LTR的百分比（每个windowsize的完整LTR的百分比）
cat genome.fa.out.LAI|awk '{print $1"\t"$2"\t"$3"\t"$4*100}'|sed '1,2d' >full_LTR_num.txt
###所有LTR的百分比（每个windowsize的LTR的百分比）
cat genome.fa.out.LAI|awk '{print $1"\t"$2"\t"$3"\t"$5*100}'|sed '1,2d' >LTR_num.txt

