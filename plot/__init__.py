"""
    Plot tools for NYC citibike tripdata
"""

import cartopy.crs as ccrs
import contextily as cx
import polars as pl
import pyproj


def transform_from_crs(df, lat_col, lng_col):
    """
    """
    crs = ccrs.epsg(3857)
    transformer = pyproj.Transformer.from_crs("EPSG:4326", crs)

    return df.with_columns(
        x_ = pl.struct([lat_col, lng_col]).map_batches(
            lambda x: transformer.transform(
                x.struct.field(lat_col), x.struct.field(lng_col))[0]
        ),
        y_ = pl.struct([lat_col, lng_col]).map_batches(
            lambda x: transformer.transform(
                x.struct.field(lat_col), x.struct.field(lng_col))[1]
        )
    )


def add_basemap(ax, zoom=11):
    cx.add_basemap(ax, zoom=zoom)


def scatter_on_map(df, lat_col, lng_col, s=1, marker='.', color='r', label=None, alpha=1, zoom=12, figsize=(10, 10)):

    df = transform_from_crs(df, lat_col, lng_col)

    ax = df.to_pandas().plot.scatter(
        'x_', 'y_',
        label=label,
        s=s,
        marker=marker,
        color=color,
        alpha=alpha,
        figsize=figsize
    )

    add_basemap(ax, zoom=zoom)
    ax.axis('off')

    if label is not None:
        ax.legend(loc='upper left')

    return ax
