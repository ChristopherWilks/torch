#!/bin/bash

#date=`date +%Y%m%d%H%M%S`
INPUT=$1
INPUT1=../tests/${INPUT}
K=21
K_sq=27

#date=${INPUT}.${SAMPLE}.${date}
date=${INPUT}.100
mkdir runs/${date}

prog=kmc
cd kmc3 && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./kmc -k$K -m900 $INPUT1 ${INPUT1}.kmc3 ./ > ../runs/${date}/${K}.1.$prog 2>../runs/${date}/${K}.2.$prog
cd ..

module load gcc/4.8.2
source squeakr/env.sh
prog=sqr
cd squeakr && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./main 0 $K_sq 4 $INPUT1 > ../runs/${date}/${K}.1.$prog 2>../runs/${date}/${K}.2.$prog
cd ..

prog=perl
./syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 perl ./count_kmers.pl $INPUT1 > ./runs/${date}/${K}.1.$prog 2> ./runs/${date}/${K}.2.$prog
