#!/bin/bash
# Script to download NYC tripdata from:
# https://s3.amazonaws.com/tripdata/index.html

CITIBIKE_URL="https://s3.amazonaws.com/tripdata/"  # Do not change
OUTPATH="../dat/raw/"

cd `dirname $0`
if [ ! -d "../dat" ]; then
    mkdir "../dat"
fi
if [ ! -d "../dat/raw" ]; then
    mkdir "../dat/raw"
fi

d="2013-06-01"  # variable for the loop
# d="2017-01-01"

while [ "$d" != "2021-04-01" ]; do
    DATE=`date +%Y%m -d "$d"`

    if [[ "$d" < "2017-01-01" ]]; then
        FILENAME=$DATE"-citibike-tripdata.zip"
        # e.g., https://s3.amazonaws.com/tripdata/201306-citibike-tripdata.zip
    else
        FILENAME=$DATE"-citibike-tripdata.csv.zip"
        # e.g., https://s3.amazonaws.com/tripdata/201701-citibike-tripdata.csv.zip
    fi
https://s3.amazonaws.com/tripdata/201701-citibike-tripdata.csv.zip 
    # echo $FILENAME
    echo $CITIBIKE_URL$FILENAME

    if [ -e $OUTPATH$FILENAME ]; then
        echo "File exists."
    else
        # Download the file
        wget $CITIBIKE_URL$FILENAME -P $OUTPATH
    fi

    d=$(date +%F -d "$d 1 month")  # update date

done
