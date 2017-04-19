#!/bin/bash

date=`date +%Y%m%d%H%M%S`
INPUT=SRR197986_1.fastq.1m
INPUT1=../tests/$INPUT
K=21
K_sq=27

mkdir runs/${date}
prog=perl
./syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 perl ./count_kmers.pl tests/${INPUT} > ./runs/${date}/${INPUT}.${K}.1.$prog 2> ./runs/${date}/${INPUT}.${K}.2.$prog

prog=kmc
cd kmc3 && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./kmc -k$K -m900 $INPUT1 ${INPUT1}.kmc3 ./ > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=sqr
cd squeakr && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./main 0 $K_sq 1 $INPUT1 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=cqf 
cd lighter_cqf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torch -r $INPUT1 -k $K 3200000000 5 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=sfs
cd lighter_sf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 3 ./torch -r $INPUT1 -k $K 3200000000 5 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=bf2
cd lighter_bf2 && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./ && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torch -r $INPUT1 -k $K 3200000000 5 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=cml
cd lighter_cml && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 10 ./torch -r $INPUT1 -k $K 3200000000 5 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
