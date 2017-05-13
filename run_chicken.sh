#!/bin/bash

for F in SRR197986_1.fastq.1m SRR197986_1.fastq.2m SRR197986_1.fastq.4m
do
	for i in 15 30 45 60 75 100
	do
		./run_sketches.sh $F $i 1230890000
	done
	./run_3rd_party.sh $F 
done
