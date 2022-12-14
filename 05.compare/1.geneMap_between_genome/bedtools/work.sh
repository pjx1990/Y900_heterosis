awk '{if ($3=="gene")print $0}' R900.gff3 >R900.gene.gff3
awk '{if ($3=="gene")print $0}' R900_gmap_msu7_cdna.gff3 >msu7.gene.gff3

# 将所有overlap 区域成对输出
 bedtools intersect -a R900.gene.gff3 -b msu7.gene.gff3 -wa -wb >gene_wa_wb.out
#只要A中的这段区域与B中区域有交集，就输出，而且overlap几次，就输出几次
 bedtools intersect -a R900.gene.gff3 -b msu7.gene.gff3 -wa >gene_wa.out
#除了输出A中的overlap区域外，还会输出B中的整个区间
 bedtools intersect -a R900.gene.gff3 -b msu7.gene.gff3 -wb >gene_wb.out
#统计A中每个区域与B overlap的次数
 bedtools intersect -a R900.gene.gff3 -b msu7.gene.gff3 -c >gene_overlap.count
#只输出A中没有与B overlap的区域
 bedtools intersect -a R900.gene.gff3 -b msu7.gene.gff3 -v >gene_nonoverlap.count
 bedtools intersect  -a msu7.gene.gff3 -b R900.gene.gff3 -v >gene_msu_uniq.count
# 一对一的gene匹配
 awk -F'\t' '{if($10==1)print $0}' gene_overlap.count >one2one.gene
# R900的unique基因
 awk -F'\t' '{if($10==0)print $0}' gene_overlap.count >r900.uniq.gene

#查找没有任何匹配的独立基因
 perl -F"Name=" -lane 'print $F[1]' gene_msu_uniq.count |sort -u |sed 's/\.[0-9]\+//g' |sort -u >msu7.uniq.gene
 cut -f 18 gene_wa_wb.out |perl -F"Name=" -lane 'print $F[1]'| sed 's/\.[0-9]\+//g' |sort -u >msu7.overlap.gene
#msu7的unique基因
 sort msu7.uniq.gene msu7.overlap.gene msu7.overlap.gene |uniq -u >final.msu7_uniq.gene
