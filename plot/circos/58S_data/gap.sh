# gap
perl -ne 'chomp;if( />(.*)/){$head = $1; $i=0; next};@a=split("",$_); foreach(@a){$i++;if($_ eq "N" && $s ==0 ){print "$head\t$i"; $s =1}elsif($s==1 && $_ ne "N"){print "\t$i\n";$s=0}}' 58S.genome.fa.softmasked >gap.bed

# nogap
perl -ne 'chomp;if( />(.*)/){$head = $1; $i=0; next};@a=split("",$_); foreach(@a){$i++;if($_ ne "N" && $s ==0 ){print "$head\t$i"; $s =1}elsif($s==1 && $_ eq "N"){print "\t$i\n";$s=0}}' 58S.genome.fa.softmasked >nogap.bed


awk '$4="color=white"' gap.bed >gap.tmp
awk '$4="color=orange"' nogap.bed >nogap.tmp
cat nogap.tmp gap.tmp >Y58S_gap.txt
sed 's/color=orange/1/g;s/color=white/-1/g' Y58S_gap.txt >Y58S_gap2.txt
sed 's/ /\t/g' Y58S_gap2.txt |sort -k1 -k2 -k3 >Y58S_gap3.txt
