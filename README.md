# NYC citibike dataset

A repository for quick access to 
NYC citibike trip history data:  
https://www.citibikenyc.com/system-data  


## Data

```download.sh``` is a shellscript to obtain trip data. Please follow the three examples.

### 1. Tripdata for a year

Use ```-y``` to download one-year data. It is separated into 12 directories, each of which has multiple CSV files up to 100M records. ```-m``` is unavailable for yearly data.

```bash
sh download.sh -y 2023 -o ./data
```

### 2. Full tripdata

Use ```-a``` to download all available trip data at once.
It will take a while to complete.

```bash
sh download.sh -a -o ./data
```

### 3. Jersey City data

Use ```-j``` to download Jersey City trip data.
```-m``` option is also required.
```bash
sh download.sh -j -y 2023 -m 01 -o ./data
```