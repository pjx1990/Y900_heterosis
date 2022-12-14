#! /usr/bin/perl -w
use strict;
my $in=shift;
open IN, "<$in " or die $!;
print "CHROM\tPOS\tREF\tALT\tR900\n";
while(<IN>){
    chomp;
    next if(/^#/);
    next if(/^unanchor/);
    my @F=split/\s+/;
    my @ref=split/:/,$F[8];
    if($F[0]=$ref[0]){
        print "$F[0]\t$F[1]\t$F[3]\t$F[4]\t$F[8]\n";
    }
}
close IN;
