#!/bin/bash

#for F in SRR197986_1.fastq.1m SRR197986_1.fastq.2m SRR197986_1.fastq.4m SRR197986_1.fastq.10m
#for F in 1m 2m 4m 10m
for i in 15 30 45 60 75 100
do
	for F in 1m 2m 4m
	do
		./run.sh $F $i
	done
done
