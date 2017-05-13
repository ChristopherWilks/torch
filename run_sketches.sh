#!/bin/bash

#date=`date +%Y%m%d%H%M%S`
#INPUT=SRR197986_1.fastq.1m
#INPUT=ecoli_reads_140_1.fq
INPUT=$1
SAMPLE=$2;
GSIZE=$3;
SAMPLE_=`bc <<< "scale = 2; ${SAMPLE} / 100"`
INPUT1=../tests/${INPUT}
#INPUT1=../tests/SRR197986_1.fastq.${INPUT}
LPARAMS="$GSIZE ${SAMPLE_}"
#LPARAMS="1230890000 ${SAMPLE_}"
#LPARAMS="3200000000 5"
K=21
K_sq=27

#date=${INPUT}.${SAMPLE}.${date}
date=${INPUT}.${SAMPLE}
mkdir runs/${date}

prog=cqf 
cd lighter_cqf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torch -r $INPUT1 -k $K ${LPARAMS} > ../runs/${date}/${K}.1.$prog 2>../runs/${date}/${K}.2.$prog
cd ..
prog=sfs
cd lighter_sf && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 3 ./torch -r $INPUT1 -k $K ${LPARAMS} -d 11 -w 100000 -z 5 -b 8 > ../runs/${date}/${K}.1.$prog 2>../runs/${date}/${K}.2.$prog
cd ..
prog=bf2
source lighter_bf2/env.sh
cd lighter_bf2 && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./ && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 5 ./torch -r $INPUT1 -k $K ${LPARAMS} -d 4 -e 1.04 -w "1000,500,100,100" -b "16,16,16,16" > ../runs/${date}/${K}.1.$prog 2>../runs/${date}/${K}.2.$prog
cd ..
prog=cml
cd lighter_cml && ../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 10 ./torch -r $INPUT1 -k $K ${LPARAMS} -d 12 -w 200000 -e 1.08 -b 8 > ../runs/${date}/${K}.1.$prog 2>../runs/${date}/${K}.2.$prog
cd ..
