#!/bin/bash
#download larger data sets for simple K-mer counting testing of torch

mkdir -p ./tests/simulate
mkdir ./runs
for f in SRR197986_1.fastq.1m SRR197986_1.fastq.1m.kmers.gz.rand1k SRR197986_1.fastq.1m.kmers.gz.rand1k.out SRR197986_1.fastq.2m SRR197986_1.fastq.2m.kmers.gz.rand1k SRR197986_1.fastq.2m.kmers.gz.rand1k.out SRR197986_1.fastq.4m SRR197986_1.fastq.4m.kmers.gz.rand1k SRR197986_1.fastq.4m.kmers.gz.rand1k.out ecoli_reads_140_1.fq ecoli_reads_140_1.fq.21.full.kmers.gz.rand1k ecoli_reads_140_1.fq.21.full.kmers.gz.rand1k.out sim_chr20_read1.fq.gz sim_chr20_read2.fq.gz
do
	wget http://snaptron.cs.jhu.edu/$f -O tests/$f
done

mv tests/sim_chr20_read?.fq.gz tests/simulate/
