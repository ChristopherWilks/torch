#!/usr/bin/perl
use strict;
use warnings;

my $prog = 'sfs';
my $cmd='cd lighter_sf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 3 ./torch -r ../tests/SRR197986_1.fastq.1m -k 21 3200000000 5';

foreach my $d ((3,5,7,9,11))
{
	foreach my $w ((20000,40000,60000,80000,100000))
	{
		foreach my $z ((1,2,3,4,5))
		{
			foreach my $b ((5,8,10,12,14))
			{
				my $new_cmd = "$cmd -d $d -w $w -z $z -b $b > ../sweeps/$prog/p$d.$w.$z.$b.1 2> ../sweeps/$prog/p$d.$w.$z.$b.2";
				`$new_cmd`;		
			}
		}
	}
}	
