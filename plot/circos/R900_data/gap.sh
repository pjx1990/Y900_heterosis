## gap
#perl -ne 'chomp;if( />(.*)/){$head = $1; $i=0; next};@a=split("",$_); foreach(@a){$i++;if($_ eq "N" && $s ==0 ){print "$head\t$i"; $s =1}elsif($s==1 && $_ ne "N"){print "\t$i\n";$s=0}}' R900.genome.fa.softmasked >gap.bed
#
## nogap
#perl -ne 'chomp;if( />(.*)/){$head = $1; $i=0; next};@a=split("",$_); foreach(@a){$i++;if($_ ne "N" && $s ==0 ){print "$head\t$i"; $s =1}elsif($s==1 && $_ eq "N"){print "\t$i\n";$s=0}}' R900.genome.fa.softmasked >nogap.bed
#
#
awk '$4="-1"' gap.bed >gap.tmp
awk '$4="1"' nogap.bed >nogap.tmp
cat nogap.tmp gap.tmp >YR900_gap.txt
sed 's/ /\t/g' YR900_gap.txt |sort -k1n  -k2n -k3n >YR900_gap3.txt
