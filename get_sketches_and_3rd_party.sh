#!/bin/bash
#unpack/git clone relevant branches from Lighter and Rcorrector and build
#as well as KMC3 and Squeakr

git clone -b cml https://github.com/ChristopherWilks/Lighter.git ./lighter_cml
git clone https://github.com/ChristopherWilks/libbf.git ./libbf
git clone -b bf2 https://github.com/ChristopherWilks/Lighter.git ./lighter_bf2
git clone -b cqf https://github.com/ChristopherWilks/Lighter.git ./lighter_cqf
git clone -b sf_sketch https://github.com/ChristopherWilks/Lighter.git ./lighter_sf
git clone https://github.com/ChristopherWilks/squeakr.git ./squeakr

git clone https://github.com/ChristopherWilks/Rcorrector.git ./Rcorrector_original
git clone -b cqf https://github.com/ChristopherWilks/Rcorrector.git ./Rcorrector_cqf
git clone -b cml https://github.com/ChristopherWilks/Rcorrector.git ./Rcorrector_cml
git clone -b bf2 https://github.com/ChristopherWilks/Rcorrector.git ./Rcorrector_bf2

for i in lighter_cml lighter_cqf lighter_sf Rcorrector_original Rcorrector_cml Rcorrector_cqf
do
	cd $i
	make clean
	make
	cd ..
done

#special library needed for BF2 (TOMB) for counting BF
source libbf/env.sh
cd libbf
make clean
./configure
make
cd ..

source lighter_bf2/env.sh
cd lighter_bf2
ln -fs ../libbf/build/src/bf/libbf.so
make clean
make
cd ..

cd Rcorrector_bf2
ln -fs ../libbf/build/src/bf/libbf.so
make clean
make
cd ..

#now 3rd party
wget https://github.com/refresh-bio/KMC/releases/download/v3.0.0/KMC3.linux.tar.gz
mkdir kmc
cd kmc
tar -zxvf ../KMC3.linux.tar.gz
cd ..

source squeakr/env.sh
cd squeakr
make clean
make
cd ..
