#!/usr/bin/perl
use strict;
use warnings;

my $prog = 'cml';
my $cmd='cd lighter_cml && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 10 ./torch -r ../tests/SRR197986_1.fastq.1m -k 21 3200000000 5';

foreach my $d ((7,10,12,15,20))
{
	foreach my $w ((80000,100000,120000,150000,200000))
	{
		foreach my $e ((1.02,1.04,1.08,1.10,1.20))
		{
			foreach my $b ((8,16,20,32,50))
			{
				my ($e1,$e2) = split(/\./,$e);
				my $outfile1 = "../sweeps/$prog/p$d.$w.$e2.$b.1";
				next if -e $outfile1;
				my $new_cmd = "$cmd -d $d -w $w -e $e -b $b > $outfile1 2> ../sweeps/$prog/p$d.$w.$e2.$b.2";
				`$new_cmd`;
			}
		}
	}
}	
