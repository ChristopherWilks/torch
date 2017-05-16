#!/bin/bash
#run Rcorrector drop-in tests for original, CQF, CML, and BF2

g++ -o verify_rcorrector verify_rcorrector.cpp

rm rcorrector_results.tsv
rm tmp_ee5818769bb7b8219347f982bed69089.bc
rm tmp_ee5818769bb7b8219347f982bed69089.mer_counts

#do initial JellyFish2 counting
./Rcorrector/jellyfish/bin/jellyfish bc -m 23 -s 100000000 -C -t 1 -o tmp_ee5818769bb7b8219347f982bed69089.bc <(gzip -cd ./tests/simulate/sim_chr20_read1.fq.gz) <(gzip -cd ./tests/simulate/sim_chr20_read2.fq.gz)

./Rcorrector/jellyfish/bin/jellyfish count -m 23 -s 100000 -C -t 1 --bc tmp_ee5818769bb7b8219347f982bed69089.bc -o tmp_ee5818769bb7b8219347f982bed69089.mer_counts <(gzip -cd ./tests/simulate/sim_chr20_read1.fq.gz) <(gzip -cd ./tests/simulate/sim_chr20_read2.fq.gz)

./Rcorrector/jellyfish/bin/jellyfish dump -L 2 tmp_ee5818769bb7b8219347f982bed69089.mer_counts > tmp_ee5818769bb7b8219347f982bed69089.jf_dump

#now run original and drop-in sketch versions
for i in Rcorrector_original Rcorrector_cqf Rcorrector_cml Rcorrector_bf2
do
	cd ${i}
	rm sim_chr20_read?.cor.fq.gz

	#run actual rcorrector code
	../syrupy.py --command-in-front --show-command --no-raw-process-log --syrupy-in-front --separator=, --no-align -i 1 ./rcorrector -t 1 -p ../tests/simulate/sim_chr20_read1.fq.gz ../tests/simulate/sim_chr20_read2.fq.gz -k 23 -c ../tmp_ee5818769bb7b8219347f982bed69089.jf_dump > sim_chr20_run.sweep.1.only 2> sim_chr20_run.sweep.2.only

	#time stat
	grep "Total run time" sim_chr20_run.sweep.2.only | perl -ne 'chomp; $f='${i}'; $f=~s/Rcorrector_//; $s=$_; $s=~/Total run time.+ (\d+) hour.+ (\d+) minute.+ (\d+\.\d+) second\(s\)$/; $run_time=$3; $run_time += (60*$2); $run_time += (60*60*$1); printf("%s\t%.0f",$f,$run_time);' >> ../rcorrector_results.tsv

	#collect peak memory stats
	cut -d',' -f 7,8 sim_chr20_run.sweep.1.only | perl -ne 'chomp; ($r,$v)=split(/,/,$_); if($r > $mr) { $mr = $r; } if($v>$mv) { $mv=$v;} END { print "\t$mr\t$mv";}' >> ../rcorrector_results.tsv
	
	#now verify the corrections
	zcat sim_chr20_read1.cor.fq.gz sim_chr20_read2.cor.fq.gz | ../verify_rcorrector -exp | head -14 | tail -4 | perl -ne 'chomp; $s=$_; ($j,$n)=split(/\s+/,$s); print "\t$n"; END { print "\n";}' >> ../rcorrector_results.tsv
	cd ..
done
