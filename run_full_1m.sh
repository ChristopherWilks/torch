#!/bin/bash

date=`date +%Y%m%d%H%M%S`
#INPUT=SRR197986_1.fastq.1m
INPUT=1m
INPUT1=../tests/SRR197986_1.fastq.${INPUT}
LPARAMS="1230890000 5"
#LPARAMS="3200000000 5"
K=21
K_sq=27

date=${INPUT}.full.${date}
mkdir runs/${date}
#prog=perl
#./syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 perl ./count_kmers.pl tests/${INPUT} > ./runs/${date}/${INPUT}.${K}.1.$prog 2> ./runs/${date}/${INPUT}.${K}.2.$prog

#prog=kmc
#cd kmc3 && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./kmc -k$K -m900 $INPUT1 ${INPUT1}.kmc3 ./ > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
#cd ..
#squeakr/clean_env.sh
#module load gcc/4.8.2
#source squeakr/env.sh
#prog=sqr
#cd squeakr && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./main 0 $K_sq 1 $INPUT1 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
#cd ..
prog=cqf 
cd lighter_cqf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torch -r $INPUT1 -k $K ${LPARAMS} > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=sfs
cd lighter_sf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 3 ./torch -r $INPUT1 -k $K ${LPARAMS} -d 11 -w 100000 -z 5 -b 8 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=bf2
source lighter_bf2/env.sh
cd lighter_bf2 && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./ && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torch -r $INPUT1 -k $K ${LPARAMS} -d 4 -e 1.04 -w "1000,500,100,100" -b "16,16,16,16" > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
prog=cml
cd lighter_cml && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 10 ./torch -r $INPUT1 -k $K ${LPARAMS} -d 12 -w 200000 -e 1.08 -b 8 > ../runs/${date}/${INPUT}.${K}.1.$prog 2>../runs/${date}/${INPUT}.${K}.2.$prog
cd ..
