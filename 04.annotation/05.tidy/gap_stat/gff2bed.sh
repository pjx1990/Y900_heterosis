#https://www.cnblogs.com/leezx/p/8647699.html
perl -ne 'chomp;if( />(.*)/){$head = $1; $i=0; next};@a=split("",$_); foreach(@a){$i++;if($_ eq "N" && $s ==0 ){print "$head\t$i"; $s =1}elsif($s==1 && $_ ne "N"){print "\t$i\n";$s=0}}' R900.genome.fa.masked >gap.bed
cat gap.bed | awk 'BEGIN{i=0}{i++;print $1,$5,$6,"Gap"i}' > gap.2.bed

