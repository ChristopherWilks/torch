#!/bin/bash

date=`date +%Y%m%d%H%M%S`
INPUT=$1
#INPUT=SRR197986_1.fastq.24m
INPUT=SRR197986_1.fastq.1m
INPUT1=../tests/$INPUT
#LPARAMS="1230890000 0.3"
LPARAMS="3200000000 5"
K=21
K_sq=27

date=${INPUT}.${date}
mkdir query_runs/${date}

#prog=kmc
#cd kmc3 && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./kmc -k$K $INPUT1 ${INPUT1}.kmc3 ./ > ../query_runs/${date}/${INPUT}.${K}.1.$prog 2>../query_runs/${date}/${INPUT}.${K}.2.$prog
#cd ..
squeakr/clean_env.sh
module load gcc/4.8.2
source squeakr/env.sh
prog=sqr
cd squeakr && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./kmer_query ${INPUT1}.ser 66475606 0 > ../query_runs/${date}/${INPUT}.${K}.1.$prog 2>../query_runs/${date}/${INPUT}.${K}.2.$prog
../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./kmer_query ${INPUT1}.ser 79837082 1 > ../query_runs/${date}/${INPUT}.${K}.1.${prog}R 2>../query_runs/${date}/${INPUT}.${K}.2.${prog}R
cd ..
prog=cqf 
cd lighter_cqf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torchq -r $INPUT1 -k $K $LPARAMS > ../query_runs/${date}/${INPUT}.${K}.1.$prog 2>../query_runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=bf2
source lighter_bf2/env.sh
cd lighter_bf2 && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./ && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torchq -r $INPUT1 -k $K $LPARAMS -d 4 -e 1.04 -w "1000,500,100,100" -b "16,16,16,16" > ../query_runs/${date}/${INPUT}.${K}.1.$prog 2>../query_runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=sfs
cd lighter_sf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 3 ./torchq -r $INPUT1 -k $K $LPARAMS -d 11 -w 100000 -z 5 -b 8 > ../query_runs/${date}/${INPUT}.${K}.1.$prog 2>../query_runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=cml
cd lighter_cml && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 10 ./torchq -r $INPUT1 -k $K $LPARAMS -d 12 -w 200000 -e 1.08 -b 8 > ../query_runs/${date}/${INPUT}.${K}.1.$prog 2>../query_runs/${date}/${INPUT}.${K}.2.$prog
cd ..
