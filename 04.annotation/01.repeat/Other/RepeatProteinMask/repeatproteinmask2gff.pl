# /usr/bin/perl -w
use strict;

my $input=shift;
my $output=shift;
open IN,$input || die "Cannot open file $input:$!";
open OUT,">$output" || die "Cannot creat file $output:$!";
while (<IN>){
	next if (/^(#|pValue)/);
	chomp;
	my @split=split;
    if (@split == 11){
            print OUT "$split[3]\tRepeatProteinMask\t$split[8]\t$split[4]\t$split[5]\t$split[1]";
        	print OUT "\t$split[6]\t.\tTarget $split[7] $split[9] $split[10]\n";
    }
    else{
            print OUT "$split[3]\tRepeatProteinMask\tNon\t$split[4]\t$split[5]\t$split[1]";
            print OUT "\t$split[6]\t.\tTarget $split[7] $split[8] $split[9]\n";
    }
}
close IN;
close OUT;
