arr=(DGpp   DGhp    Y900.R900   Y900.Y58S   DGhpu   DGo PDO DO  ODO H2P CHP B2P CLP L2P P1  P2  P3  P4  P5  P6  P7  P8  P9  P10 P11 P12 Other)
for i in ${arr[@]};do
echo $i
# 提取各杂优模式的交集
#sort ../gene.lst ../../1P/${i}.txt |uniq -d >${i}.txt #???取不了交集
grep -F -f ../gene.lst ../../L-S-1P-5P_stat/1P/${i}.txt |sort -u >${i}.txt
done

#统计结果
wc -l *.txt |sed 's/.txt//g' |sed '/total/d' |awk -F' ' '{print $2"\t"$1}' >../1P.txt
