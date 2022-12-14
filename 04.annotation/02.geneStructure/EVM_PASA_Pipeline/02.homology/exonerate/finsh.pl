#! /usr/bin/perl -w
use strict;
my $in = shift;
open IN,"<$in" or die $!;
while(<IN>){
    chomp;
if(/Target=(\w+)/){
#    if(/sequence (\w+) ; (.*)/){
        print "$1\n";
    }
}
close IN;
