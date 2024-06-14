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
# download tripdata for 2023
$ sh download.sh -y 2023 -o ./data/

# download tripdata for Jan 2023
$ sh download.sh -y 2023 -m 01 -o ./data/
```

Run ```download_full.sh``` to download all available yearly tripdata.

```bash
$ sh download_full.sh OUTDIR
```