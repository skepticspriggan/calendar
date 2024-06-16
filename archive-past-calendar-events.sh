#!/usr/bin/env bash

directory=$1

set -euxo pipefail

if [ $# -eq 0 ]; then
    >&2 echo 'Missing required parameter directory. Specify which directory should be searched for the calendar files by adding ` directory`'
    exit 1
fi

awk -v date="$(date +'%F')" '$1 < date { print$0 }' $directory/calendar-future.txt \
  | tee /tmp/to-past.txt \
  >> $directory/calendar-past.txt

if [ -s /tmp/to-past.txt ]; then
  #echo "" >> $directory/calendar-past.txt
  rm /tmp/to-past.txt
fi

awk -v date="$(date +'%F')" '$1 >= date { print$0 }' $directory/calendar-future.txt > /tmp/calendar-future.txt && mv /tmp/calendar-future.txt $directory/calendar-future.txt
