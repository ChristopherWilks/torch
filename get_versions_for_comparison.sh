#!/bin/bash

git clone -b cml https://github.com/ChristopherWilks/Lighter.git ./lighter_cml
git clone -b bf2 https://github.com/ChristopherWilks/Lighter.git ./ligther_bf2
git clone -b cqf https://github.com/ChristopherWilks/Lighter.git ./ligther_cqf
git clone -b sf_sketch https://github.com/ChristopherWilks/Lighter.git ./ligther_sf
git clone -b sf_sketch https://github.com/ChristopherWilks/squeakr.git ./squeakr

for i in lighter_cml ligther_cqf ligther_sf
do
	cd $i && make clean && make
	cd ..
done

wget https://github.com/refresh-bio/KMC/releases/download/v3.0.0/KMC3.linux.tar.gz
gunzip -zxvf KMC3.linux.tar.gz

source lighter_bf2/env.sh
cd lighter_bf2 && make clean && make
cd ..

source squeakr/env.sh
cd squeakr && make clean && make
