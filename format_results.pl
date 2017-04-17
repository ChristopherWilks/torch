#!/bin/bash/perl

use strict;
use warnings;

my $dir = shift;
my $correct = shift;

my ($c_nkmers_seen,$c_nkmers_seen_clean,$c_nkmers_added,$c_nkmers_uniq_gt_1)=split(/,/,$correct);

print "program\tfilename\tnum_reads\tK\trun_time\tmax_rss\tmax_vmem\tdiff_total_kmers\tdiff_total_kmers_added\tdiff_num_kmers_gt_1\ttotal_kmers\ttotal_kmers_added\tnum_kmers_gt_1\tsampled\n";
my $max_rss = 0;
my $max_vmem = 0;
my $nkmers_seen = 0;
my $nkmers_seen_clean = 0;
my $nkmers_added = 0;
my $nkmers_uniq_gt_1 = 0;

foreach my $f (`ls $dir | sort -t'.' -k7,7 -k6,6n`)
{
	chomp($f);
	my ($date,$fname,$ftype,$nreads,$k,$fnum,$prog)=split(/\./,$f);
	#print "$date,$fname,$ftype,$nreads,$k,$fnum,$prog\n";
	my $sampled=0;
	my $run_time = 0;
	
	
	if($fnum == 1)
	{
		$max_rss = 0;
		$max_vmem = 0;
		$nkmers_seen = 0;
		$nkmers_seen_clean = 0;
		$nkmers_added = 0;
		$nkmers_uniq_gt_1 = 0;
		foreach my $e (`grep "S_Y_P" $dir/$f | cut -f2-`)
		{
			chomp($e);
			my ($PID,$DATE,$TIME,$ELAPSED,$CPU,$MEM,$RSS,$VSIZE,$CMD,$COMMAND) = split(/,/,$e);
			$max_rss = $RSS if($RSS > $max_rss);
			$max_vmem = $VSIZE if($VSIZE > $max_vmem);
		}
		if($prog eq 'sqr' || $prog eq 'kmc' || $prog eq 'perl')
		{
			open(IN,"$dir/$f");
			while(my $line = <IN>)
			{
				chomp($line);
				if($prog eq 'perl')
				{
					($nkmers_seen,$nkmers_seen_clean,$nkmers_added,$nkmers_uniq_gt_1)=split(/,/,$line);
					last;
				}
				$nkmers_seen_clean=$1 if($line=~/Total num elems: (\d+)$/ && $prog eq 'sqr');
				$nkmers_added=$1 if($line=~/Num distinct elem: (\d+)$/ && $prog eq 'sqr');
				
				$nkmers_seen_clean=$1 if($line=~/Total no. of k-mers.+ (\d+)$/ && $prog eq 'kmc');
				$nkmers_added=$1 if($line=~/No. of unique k-mers.+ (\d+)$/ && $prog eq 'kmc');
				$nkmers_uniq_gt_1=$1 if($line=~/No. of unique counted k-mers.+ (\d+)$/ && $prog eq 'kmc');
			}
			close(IN);	
		}
	}
	else
	{
		open(IN,"$dir/$f");
		while(my $line = <IN>)
		{
			chomp($line);
			$run_time=$1 if($line=~/Total run time.+ (\d+\.\d+) second\(s\)$/);
			$sampled=$1 if($line=~/Completed running.+([\d\.]+)$/);
			next if($prog eq 'sqr' || $prog eq 'kmc' || $prog eq 'perl');
			$nkmers_seen=$1 if($line=~/Non-unique K-mers seen (\d+)$/);	
			$nkmers_added=$2 if($line=~/(Non|mostly)-unique K-mers added (\d+)$/);	
			$nkmers_uniq_gt_1=$1 if($line=~/total # of kmers with > 1 occurrences: (\d+)$/);
		}
		$sampled = ($sampled < 1 && $sampled > 0) ? 1 : 0;
		close(IN);
		my $d_nkmers_seen = $nkmers_seen-$c_nkmers_seen;
		$d_nkmers_seen = $nkmers_seen_clean-$c_nkmers_seen_clean if($prog eq 'kmc' || $prog eq 'sqr');
		my $d_nkmers_added = $nkmers_added-$c_nkmers_added;
		my $d_nkmers_uniq_gt_1 = $nkmers_uniq_gt_1-$c_nkmers_uniq_gt_1;
		print "$prog\t$fname\t$nreads\t$k\t$run_time\t$max_rss\t$max_vmem\t$d_nkmers_seen\t$d_nkmers_added\t$d_nkmers_uniq_gt_1\t$nkmers_seen\t$nkmers_added\t$nkmers_uniq_gt_1\t$sampled\n";
	}
}
