#!/bin/sh
# URL https://s3.amazonaws.com/tripdata/index.html


SOURCE_URL="https://s3.amazonaws.com/tripdata/"  # Do not change

OUTPUT_PATH="./rawdata/"
DATE_FROM="2017-01-01"

cd `dirname $0`

if [ ! -d $OUTPUT_PATH ]; then
    mkdir $OUTPUT_PATH
fi

NOW=`date +%Y%m`
DATE=`date +%Y%m -d "${DATE_FROM}"`  # variable for loop
echo $NOW

while [ "$DATE" != "$NOW" ]; do

    FILENAME="${DATE}-citibike-tripdata.csv.zip"
    echo $SOURCE_URL$FILENAME
    # e.g., https://s3.amazonaws.com/tripdata/201701-citibike-tripdata.csv.zip

    if [ -e $OUTPUT_PATH$FILENAME ]; then
        echo "File exists."
    else
        # Download the file
        wget $SOURCE_URL$FILENAME -P $OUTPUT_PATH
    fi

    # update date
    DATE_FROM=$(date +%F -d "${DATE_FROM} 1 month")
    DATE=`date +%Y%m -d "${DATE_FROM}"`

done
