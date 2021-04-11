#!/bin/bash

DATA_PATH="../dat/raw/"

cd `dirname $0`
cd $DATA_PATH

ls | grep ".zip" | xargs -n1 unzip