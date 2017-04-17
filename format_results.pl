#!/bin/bash/perl

use strict;
use warnings;

my $dir = shift;

print "program\tfilename\tnum_reads\tK\trun_time\tmax_rss\tmax_vmem\ttotal_kmers\ttotal_kmers_added\tnum_kmers_gt_1\tsampled\n";
my $max_rss = 0;
my $max_vmem = 0;
foreach my $f (`ls $dir | sort -t'.' -k7,7 -k6,6n`)
{
	chomp($f);
	my ($date,$fname,$ftype,$nreads,$k,$fnum,$prog)=split(/\./,$f);
	#print "$date,$fname,$ftype,$nreads,$k,$fnum,$prog\n";
	my $nkmers_seen = 0;
	my $nkmers_added = 0;
	my $nkmers_uniq_gt_1 = 0;
	my $sampled=0;
	my $run_time = 0;
	
	
	if($fnum == 1)
	{
		$max_rss = 0;
		$max_vmem = 0;
		foreach my $e (`grep "S_Y_P" $dir/$f | cut -f2-`)
		{
			chomp($e);
			my ($PID,$DATE,$TIME,$ELAPSED,$CPU,$MEM,$RSS,$VSIZE,$CMD,$COMMAND) = split(/,/,$e);
			$max_rss = $RSS if($RSS > $max_rss);
			$max_vmem = $VSIZE if($VSIZE > $max_vmem);
		}
	}
	else
	{
		open(IN,"$dir/$f");
		while(my $line = <IN>)
		{
			chomp($line);
			$nkmers_seen=$1 if($line=~/Non-unique K-mers seen (\d+)$/);	
			$nkmers_added=$2 if($line=~/(Non|mostly)-unique K-mers added (\d+)$/);	
			$nkmers_uniq_gt_1=$1 if($line=~/total # of kmers with > 1 occurrences: (\d+)$/);
			$sampled=$1 if($line=~/Completed running.+([\d\.]+)$/);
			$run_time=$1 if($line=~/Total run time.+ (\d+\.\d+) second\(s\)$/);
		}
		$sampled = ($sampled < 1 && $sampled > 0) ? 1 : 0;
		close(IN);
		print "$prog\t$fname\t$nreads\t$k\t$run_time\t$max_rss\t$max_vmem\t$nkmers_seen\t$nkmers_added\t$nkmers_uniq_gt_1\t$sampled\n";
	}
}
