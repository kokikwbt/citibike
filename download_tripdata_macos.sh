#!/bin/sh
# URL https://s3.amazonaws.com/tripdata/index.html


SOURCE_URL="https://s3.amazonaws.com/tripdata/"  # Do not change

OUTPUT_PATH="./rawdata/"
DATE="2017-01-01"

cd `dirname $0`

if [ ! -d $OUTPUT_PATH ]; then
    mkdir $OUTPUT_PATH
fi

TODAY=`date +%Y%m`
DATE=`date -j -f "%Y-%m-%d" ${DATE} +"%Y%m"`
NAME="-citibike-tripdata.csv.zip"

while [ "$DATE" != "$TODAY" ]; do

    FILENAME=$DATE$NAME
    # e.g., https://s3.amazonaws.com/tripdata/201701-citibike-tripdata.csv.zip

    if [ -e $OUTPUT_PATH$FILENAME ]; then
        echo "File exists."
    else
        # Download the file
        wget $SOURCE_URL$FILENAME -P $OUTPUT_PATH
    fi
    # update date
    DATE=`date -j -v +1m -f "%Y%m" ${DATE} +"%Y%m"`
done
