#!/bin/bash

./get_data.sh
./get_sketches_and_3rd_party.sh

g++ -o verify_rcorrector verify_rcorrector.cpp
