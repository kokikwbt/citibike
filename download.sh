#!/bin/bash
# NYC citibike tripdata downloader
# Homepage: https://citibikenyc.com/
# Please read: https://ride.citibikenyc.com/data-sharing-policy

URL="https://s3.amazonaws.com/tripdata/"

# Default parameters
OUTDIR="./data/"
YEAR=2023
START=2013
END=2023

cd `dirname $0`

while getopts ajy:m:o: OPT
do
    case $OPT in
        a)
            # All tripdata will be downloaded if specified
            ALL=1
            ;;
        j)
            # Jersey City data will be downloaded if 1
            # It also needs to specify YEAR and MONTH
            JC=1
            ;;
        y)
            YEAR=${OPTARG}
            ;;
        m)  MONTH=${OPTARG}  # e.g., "01"
            ;;
        o)
            OUTDIR=${OPTARG}
            ;;
        *) 
            echo "Usage: $(basename ${0}) [-y YEAR] [-m MONTH] [-o OUTDIR]"
            exit 1
            ;;
    esac
done

if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

if [ ! -z $ALL ]; then
    for YEAR in $(seq $START $END); do
        wget "${URL}${YEAR}-citibike-tripdata.zip" -P $OUTDIR
    done
elif [ ! -z $JC ]; then
    wget "${URL}JC-${YEAR}${MONTH}-citibike-tripdata.csv.zip" -P $OUTDIR
else
    wget "${URL}${YEAR}-citibike-tripdata.zip" -P $OUTDIR
fi