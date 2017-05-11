#!/usr/bin/perl
use strict;
use warnings;

my $prog = 'bf2';
my $cmd='cd lighter_bf2 && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 3 ./torch -r ../tests/SRR197986_1.fastq.1m -k 21 3200000000 5';
#-d 4 -w 1,4,4,4 -b 4,4,4,4 -e 1.08
foreach my $d_ ([1,("10000","40000","80000")],[4,("100,100,50,50","1000,500,100,100","10000,1000,500,500","100000,10000,1000,1000","1000000,100000,10000,10000")])
#[8,("1,2,2,2,4,4,4,4","1,2,2,4,4,8,8,16","4,4,4,4,8,8,8,8")])
{
	my ($d,@a)=@$d_;
	foreach my $w (@a)
	{
		foreach my $e ((1.02,1.04,1.08,1.10,1.20))
		{
			foreach my $b (("2","4","8","16"))
			{
				my $b_=$b.",";
				$b_ = $b_ x $d;
				$b_ =~ s/,$//;
				my ($e1,$e2) = split(/\./,$e);
				my $outfile1 = "../sweeps/$prog/p$d"."_$e2"."_$w"."_$b"."_1";
				my $outfile2 = "../sweeps/$prog/p$d"."_$e2"."_$w"."_$b"."_2";
				$outfile1 =~ s/,/\./g;
				$outfile2 =~ s/,/\./g;
				next if -e $outfile1;
				my $new_cmd = "$cmd -d $d -w $w -e $e -b $b > $outfile1 2> $outfile2";
				print "$new_cmd\n";
				`$new_cmd`;
			}
		}
	}
}	
