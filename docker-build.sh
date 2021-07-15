#!/bin/sh

NAME="devunderslash/test"
TIMESTAMP=`date +%Y%m%d%H%M%S`
LOG=`git log -1 --pretty=%h`
VERSION="${LOG}${TIMSTAMP}"
IMG=$NAME:$LOG"-"$TIMESTAMP

LATEST=$IMG:latest  

echo "$IMG"


docker build -t $IMG .