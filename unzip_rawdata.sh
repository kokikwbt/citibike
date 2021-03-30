#!/bin/bash

DATA_PATH="./raw/"

cd `dirname $0`
cd $DATA_PATH

ls | grep ".zip" | xargs -n1 unzip