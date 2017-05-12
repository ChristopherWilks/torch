#!/bin/bash

echo "program	filename	num_reads	K	run_time	max_rss	max_vmem	diff_total_kmers	diff_total_kmers_added	diff_num_kmers_gt_1	total_kmers	total_kmers_clean	total_kmers_added	num_kmers_gt_1	avg_abs_diff_in	avg_abs_diff_out	sampled" > all_sampled.tsv
for i in 1m 2m 4m 10m
do
	for f in 15 30 45 60 75 100 
	do
		perl ./format_results.pl ./runs/${i}.${f} 80000000,79837082,66540175,3424406 ${f} >> all_sampled.tsv
	done
done
