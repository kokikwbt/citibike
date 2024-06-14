#!/bin/bash
# NYC citibike tripdata downloader
# Homepage: https://citibikenyc.com/
# Please read: https://ride.citibikenyc.com/data-sharing-policy

URL="https://s3.amazonaws.com/tripdata/"

# Default parameters
Y="2023"
M=""
OUTDIR="./data/"

cd `dirname $0`


while getopts y:m:o: OPT
do
    case $OPT in
        y)
            Y=${OPTARG}  # year
            ;;
        m)
            M=${OPTARG}  # month (e.g., 01)
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


if [ $M ]; then
    FN="JC-${Y}${M}-citibike-tripdata.csv.zip"
else
    FN="${Y}-citibike-tripdata.zip"
fi


if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

wget $URL$FN -P $OUTDIR