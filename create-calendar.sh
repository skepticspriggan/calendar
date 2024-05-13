#!/bin/env bash

#set -euxo pipefail

date=$1
end=$2
seconds_since_end=$(date -d "$end" +'%s')

while [ $(date -d "$date" +'%s') -le $seconds_since_end ]; do
  echo $(date -d $date +'%F w%V %u')
  date=$(date -d "$date + 1 day" +'%F')
done
