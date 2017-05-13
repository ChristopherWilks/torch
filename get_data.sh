#!/bin/bash
#download larger data sets for simple K-mer counting testing of torch

mkdir ./tests
mkdir ./runs
for f in SRR197986_1.fastq.1m SRR197986_1.fastq.1m.kmers.gz.rand1k SRR197986_1.fastq.1m.kmers.gz.rand1k.out SRR197986_1.fastq.2m SRR197986_1.fastq.2m.kmers.gz.rand1k SRR197986_1.fastq.2m.kmers.gz.rand1k.out SRR197986_1.fastq.4m SRR197986_1.fastq.4m.kmers.gz.rand1k SRR197986_1.fastq.4m.kmers.gz.rand1k.out ecoli_reads_140_1.fq
do
	wget http://snaptron.cs.jhu.edu/$f -O tests/$f
done
