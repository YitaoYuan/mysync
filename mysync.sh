#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: ./rsync.sh <FILE|DIR> <DEST>"    
    exit 1
fi

FILE=`realpath -e $1`

if [[ $FILE == /root* ]]; then
    CUT_DIR=${FILE#*/root}
elif [[ $FILE == /home* ]]; then
    CUT_DIR=${FILE#*/home}
else
    echo "FILE must under /root or /home"
    exit 1
fi 

if [ -z $CUT_DIR ]; then
    echo "FILE must under /root or /home, but can not be themselves"
    exit 1
fi 

CUT_DIR=$(dirname $CUT_DIR)

if [[ "$2" == *worker* ]]; then
    REM_DIR=/home/yyt$CUT_DIR # CUT_DIR starts with '/'
else
    REM_DIR=/root/yyt$CUT_DIR
fi

set -x
rsync --exclude "*/.*" --exclude ".*" -v -r $FILE $2:$REM_DIR