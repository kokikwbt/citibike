# NYC citibike dataset

A repository for quick access to 
NYC citibike trip history data:  
https://www.citibikenyc.com/system-data  


## Usage

Run ```download.sh``` to download a file.
- -y: year, YYYY
- -m: month, MM
- -o: output directory

```bash
# download tripdata of a specified year
$ sh download.sh -y 2023 -o ./data/

# download JC tripdata of specified year and month
$ sh download.sh -y 2023 -m 01 -o ./data/
```

Yearly tripdata contains 12 directories (e.g., 1_January)  
and each directory contains some CSV files consisting of up to 100M trips.  
"JC" refers to Jersey City,  
JC tripdata are smaller than the yearly tripdata.

Run ```download_full.sh``` to download all available yearly tripdata.

```bash
$ sh download_full.sh OUTDIR
```