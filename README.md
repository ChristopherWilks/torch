# torch
Currently Torch is for comparing various probabilistic data structures for use in D/RNA k-mer counting.

These include:
-Multi layer spectral bloom filters (BF2)
-Count-min sketch w/ log counter (CML)
-Slim-fat sketch (SF)
-Counting Quotient Filter (CQF)

Also contains a copy of the main scripts from:
https://github.com/jeetsukumaran/Syrupy

for time/memory tracking.

## Setup
This will grab the K-mer counting test read sets
and the various sketch version of Lighter, KMC3, and squeakr

	./setup.sh

## Run Chicken (SRR197986) K-mer Counting Tests
This will run multiple read sets with various sample sizes

	./run_chicken.sh

## Run E. coli 140x Simulated K-mer Counting Tests
This will run the full read set with various sample sizes

	./run_ecoli_140x.sh
	
