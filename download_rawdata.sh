#!/bin/bash

if [ ! -d "raw" ]; then
    mkdir "raw"
fi

CITIBIKE_URL="https://s3.amazonaws.com/tripdata/"

d="2013-06-01"  # variable for the loop

while [ "$d" != "2021-01-01" ]; do
    DATE=`date +%Y%m -d "$d"`
    if [[ "$d" < "2017-01-01" ]]; then
        FILENAME=$CITIBIKE_URL$DATE"-citibike-tripdata.zip"
    else
        FILENAME=$CITIBIKE_URL$DATE"-citibike-tripdata.csv.zip"
    fi
    echo $FILENAME

    # Download the file
    wget $FILENAME -P "./raw/"
    d=$(date +%F -d "$d 1 month")  # update date
done
