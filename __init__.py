import calendar
import glob
import os
import yaml
import polars as pl

from . import utils
from . import plot


HERE = os.path.dirname(__file__)
with open(HERE + '/config.yaml', 'r') as f:
    config = yaml.safe_load(f)


DTYPES = {
    'ride_id':              pl.Utf8,
    'rideable_type':        pl.Utf8,
    'started_at':           pl.Datetime,
    'ended_at':             pl.Datetime,
    'start_station_name':   pl.Utf8,
    'end_station_name':     pl.Utf8,
    'end_station_id':       pl.Utf8,
    'start_lat':            pl.Float32,
    'start_lng':            pl.Float32,
    'end_lat':              pl.Float32,
    'end_lng':              pl.Float32,
    'member_casual':        pl.Utf8
}


class DataLoader:
    def __init__(self) -> None:
        pass

    @staticmethod
    def read_csv(year, month):
        # multiple csv files are automatically concatenated
        fn = os.path.join(HERE,
                          config['data_path'],
                          str(year) + '-citibike-tripdata',
                          str(month) + '_' + calendar.month_name[month],
                          '*.csv')

        return pl.read_csv(fn, dtypes=DTYPES, infer_schema_length=False)