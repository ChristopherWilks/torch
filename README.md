# torch
Currently Torch is for comparing various probabilistic data structures for use in D/RNA k-mer counting.

These include:
* Multi layer spectral bloom filters (BF2)
* Count-min sketch w/ log counter (CML)
* Slim-fat sketch (SF)
* Counting Quotient Filter (CQF)

The following steps have been partially tested on a MARCC bigmem machine. 

The simple K-mer counting tests will take 1) hours to run and 2) 10's of gigabytes of memory.

## Setup
This will grab the K-mer counting test read sets
and the various sketch version of Lighter, KMC3, and squeakr

	./setup.sh

## Run Chicken low-coverage (SRR197986) K-mer Counting Tests
This will run multiple read sets with various sample sizes

	./run_chicken.sh

## Run E. coli 140x Simulated K-mer Counting Tests
This will run the full read set with various sample sizes

	./run_ecoli_140x.sh

## Run Rcorrector sketch tests on Human chromosome 20 simulated reads
Check the rcorrector\_results.tsv file for tabular results

	./run_rcorrector_tests.sh	


Also this repo contains a copy of the scripts from:
https://github.com/jeetsukumaran/Syrupy

for time/memory tracking.

Code/libraries were forked/included from the following repos:

* https://github.com/mourisl/Rcorrector
* https://github.com/mourisl/rcorrector_paper_script
* https://github.com/mourisl/Lighter
* https://github.com/mourisl/Lighter_paper
* https://github.com/splatlab/squeakr
* https://github.com/mavam/libbf
* https://github.com/paper2017/SF-sketch
* https://github.com/efficient/cuckoofilter
