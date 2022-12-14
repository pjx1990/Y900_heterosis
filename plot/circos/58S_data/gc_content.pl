#https://blog.csdn.net/hugolee123/article/details/38441927
#! /usr/bin/perl -w
use strict;
die "#usage:perl $0 <BananaB.chr_V2.1.final.fa>\n" unless @ARGV==1;
my $fa=shift;
my $bin=50000; ##50k window
open IN,$fa||die;
$/=">";<IN>;$/="\n";
print "#Chr\tStart\tEnd\tGC_num\tRatio\n";
while(<IN>){
	my $chr=$1 if /^(\S+)/;
	$/=">";
	chomp(my $seq=<IN>);
	$/="\n";
	$seq=~s/\n+//g;
	my $len=length$seq;
	for (my $i=0;$i<$len/$bin;$i++){
		my $loc=$i*$bin;
		my $sub_fa=uc(substr($seq,$loc,$bin));
		my $GC=$sub_fa=~tr/GC//;
		my $ratio=sprintf "%.4f",$GC/$bin;
		my $start=$i*$bin+1;
		my $end=($i+1)*$bin;
		my $out=join "\t",$chr,$start,$end,$GC,$ratio;
		print $out,"\n";
		#print "$out\t$sub_fa\n" unless $GC;
	}	
}
close IN;
