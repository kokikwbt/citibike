""" Plot tools for NYC """

import matplotlib.pyplot as plt
import seaborn as sns
import contextily as cx
from pyproj import Proj, transform


def my_transform(df):
    lon = df.iloc[1]
    lat = df.iloc[0]
    # Available for CitiBike dataset
    return transform(Proj(init='epsg:4326'), Proj(init='epsg:3857'), lat, lon)


def plot_size_on_nyc(df, ax=None, alpha=0.5, color='blue', edgecolor='none', outfn=None):

    if ax is None:
        fig, ax = plt.subplots(figsize=(10, 12))

    geo_specific_size = df.groupby(['startstationlongitude', 'startstationlatitude']).size().rename('size').reset_index()
    transformed_geo = geo_specific_size[['startstationlongitude', 'startstationlatitude']].apply(my_transform, axis=1)
    transformed_geo = transformed_geo.rename('geo_info').reset_index()
    geo_specific_size['trans_lon'], geo_specific_size['trans_lat'] = zip(*transformed_geo.geo_info)

    ax = sns.scatterplot(data=geo_specific_size, ax=ax,
        x='trans_lon', y='trans_lat', size='size',
        alpha=alpha, color=color, edgecolor=edgecolor)

    ax.legend(fancybox=False)
    ax.axis('off')
    ax.margins(0)
    cx.add_basemap(ax)

    if outfn is not None:
        fig.tight_layout()
        fig.savefig(outfn, bbox_inches='tight', pad_inches=0)

    return ax