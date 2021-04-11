#!/bin/sh

DATA_PATH="../dat/raw/"

cd `dirname $0`
cd $DATA_PATH

d="2013-07-01"  # variable for the loop

while [ "$d" != "2014-09-01" ]; do
    DATE=`date +%Y%m -d "$d"`
    if [ -e `date +%Y-%m -d "$d"`" - Citi Bike trip data.csv" ]; then
        mv `date +%Y-%m -d "$d"`" - Citi Bike trip data.csv" $DATE"-citibike-tripdata.csv"
    fi
    d=$(date +%F -d "$d 1 month")  # update date
done
