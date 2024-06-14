#!/bin/bash

cd `dirname $0`

OUTDIR=$1

if [ ! $OUTDIR ]; then
    echo "ERROR: an output directory must be specified"
    exit 1
fi

sh download.sh -y 2013 -o $OUTDIR
sh download.sh -y 2014 -o $OUTDIR
sh download.sh -y 2015 -o $OUTDIR
sh download.sh -y 2016 -o $OUTDIR
sh download.sh -y 2017 -o $OUTDIR
sh download.sh -y 2018 -o $OUTDIR
sh download.sh -y 2019 -o $OUTDIR
sh download.sh -y 2020 -o $OUTDIR
sh download.sh -y 2021 -o $OUTDIR
sh download.sh -y 2022 -o $OUTDIR
sh download.sh -y 2023 -o $OUTDIR