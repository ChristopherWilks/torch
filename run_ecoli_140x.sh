#!/bin/bash

for F in ecoli_reads_140_1.fq
do
	for i in 15 30 45 60 75 100
	do
		./run_sketches.sh $F $i 4641652
	done
	./run_3rd_party.sh $F 
done
