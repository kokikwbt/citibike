"""
    Utility functions for processing NYC CitiBike Dataset

"""

import os
import zipfile
import pandas as pd


rootpath = os.path.dirname(__file__)


def cleaning(df, user_type=None, add_user_age=True):

    df.columns = df.columns.str.lower()
    df.columns = df.columns.str.replace(' ', '')

    df = df.dropna(subset=['birthyear'])
    
    if user_type is not None:
        assert user_type in ['Subscriber', 'Customer']
        df = df.query('usertype==@user_type')

    df.loc[:, 'starttime'] = pd.to_datetime(df.starttime)
    df.loc[:, 'stoptime'] = pd.to_datetime(df.stoptime)
    df.loc[:, 'year'] = df.starttime.dt.year
    df.loc[:, 'hour'] = df.starttime.dt.hour
    df.loc[:, 'weekday'] = df.starttime.dt.weekday.astype(str).str.cat(
        df.starttime.dt.day_name().str[:3], sep='-')
    df.loc[:, 'weekday-hour'] = df.hour.astype(str).str.cat(
        df.starttime.dt.day_name().str[:3], sep='-')

    if add_user_age:
        df.loc[:, 'user_age'] = df.year - df.birthyear
        df = df.query('user_age>=0')
        df = df.query('user_age<=80')

    return df


def load_data(date=None, date_from=None, date_to=None, clean=True):
    """
        date: (str) e.g., '201701'
        date_from: (datetime object)
        date_to: (datetime object)
        clean: (bool)
    """

    if date is not None:
        zip_file = zipfile.ZipFile(rootpath + f'/rawdata/{date}-citibike-tripdata.csv.zip')
        data = pd.read_csv(zip_file.open(zip_file.namelist()[0]))
        # data = pd.read_csv(f'../rawdata/{date}-citibike-tripdata.csv.zip', compression='zip')
        if clean:
            return cleaning(data)
        else:
            return data

    else:
        return pd.concat([load_data(date.strftime("%Y%m"))
            for date in pd.date_range(start=date_from, end=date_to, freq='M')])


def define_non_temporal_modes(df, facets, freq_rate=0.9, skip_mode=None):
    """
        df: DataFrame object of trip data
        facets: List of column names used in analysis
        freq_rate: threshold to extract frequent attributes
        skip_mode: List of boolian values.
            If True, then skip the mode in frequent attribute extraction
    """
    if skip_mode is None:
        skip_mode = [False] * len(facets)

    # Extracting the top [freq_rate] % attritbutes for each mode
    freq_rates = df[facets].nunique().values * freq_rate
    freq_shape = freq_rates.astype(int)
    freq_entities = [df.groupby(a).size().sort_values().iloc[-r:].index if not s else [] for a, r, s in zip(facets, freq_shape, skip_mode)]

    # Filtering out the infrequent attributes
    valid_events = df
    for i, (mode, skip) in enumerate(zip(facets, skip_mode)):
        if not skip:
            valid_events = valid_events[valid_events[mode].isin(freq_entities[i])]

    print('Filtered out {} samples'.format(df.shape[0] - valid_events.shape[0]))

    # Getting the attributes to keep track
    multi_index = valid_events.groupby(facets).size().rename('size').to_frame()
    multi_index = multi_index.unstack(fill_value=0).stack()

    shape = valid_events[facets].nunique().values.astype(int)

    return multi_index, shape