#!/bin/bash

git clone -b cml git@github.com:ChristopherWilks/Lighter.git ./lighter_cml
git clone -b bf2 git@github.com:ChristopherWilks/Lighter.git ./ligther_bf2
git clone -b cqf git@github.com:ChristopherWilks/Lighter.git ./ligther_cqf
git clone -b sf_sketch git@github.com:ChristopherWilks/Lighter.git ./ligther_sf
git clone https://github.com/splatlab/squeakr.git
wget https://github.com/refresh-bio/KMC/releases/download/v3.0.0/KMC3.linux.tar.gz
gunzip -zxvf KMC3.linux.tar.gz
