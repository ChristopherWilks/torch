#!/bin/bash/perl
#get exact count of:
#1) all kmers (non-unique)
#2) all unique kmers
#3) all unique kmers with ocurrence > 1
#this is ground truth
#
#also only counts "clean" kmers (by Lighter's def)
#1) skips reads with < $K length or with non-ATCGs
#2) only counts cannonical kmer

use strict;
use warnings;

my $K=21;
my %h2=("N"=>"N","A"=>"T","G"=>"C","C"=>"G","T"=>"A"); 
my %h;
my $c=0;
my $total=0; 
my $total_clean=0; 

my $file = shift;
my $K_ = shift;
my $print_kmers = shift;
$K = $K_ if($K_);

#open(IN,"<SRR197986_1.fastq.1m"); 
open(IN,$file); 
while(my $line=<IN>) 
{ 
	chomp($line); 
	$c++; 
	my $r=$line; 
	next if($c%4!=2 || length($r) < $K); 
	for(my $i=0;$i<(length($r)-$K)+1;$i++) 
	{
		my $k=substr($r,$i,$K); 
		$total++;
		next if($k=~/[^ATCG]/); 
		my @k=split(//,$k); 
		my @k1=(); 
		for(my $j=$K-1;$j>=0;$j--) 
		{ 
			push(@k1,$h2{$k[$j]}); 
		} 
		my $k2=join("",@k1); 
		my $k3=$k gt $k2?$k2:$k; 
		$total_clean++; 
		$h{$k3}++; 
	}
} 
close(IN); 
my $count2=0;
#my @order_diffs=((0,""),(0,""),(0,""));
my @order_diffs;
my $max_order=6;
for my $i (0..$max_order)
{
	push(@order_diffs, [0,""]);
}

for my $e (keys %h) 
{ 
	my $c1=$h{$e}; 
	if($print_kmers)
	{
		my $order_mag = int(log($c1)/log(10));
		if($order_mag <= $max_order)
		{
			$order_diffs[$order_mag]->[0] = $c1;
			$order_diffs[$order_mag]->[1] = $e;
		}
		print STDERR "$e\t$c1\n";
	}
	$count2++ if($c1>1); 
}
my $count1=scalar (keys %h);

if($print_kmers)
{
	for my $i (0..$max_order)
	{
		my ($c,$k) = @{$order_diffs[$i]};
		print STDERR "ORDER\t$i\t$k\t$c\n";
	}
}	

print "$total,$total_clean,$count1,$count2\n";
