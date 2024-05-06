#!/bin/env bash

# set -euxo pipefail

# date_pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2} w[0-9]* (Mon|Tue|Wed|Thu|Fri|Sat|Sun)+"
date_pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2} w[0-9]* [1-7]{1}"
week_pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2} w[0-9]*"

awk -v start="$(date +'%F')" \
  -v end="$(date -d '+1 weeks' +'%F')" \
  '$1 >= start && $1 < end { print$0 }' calendar.txt \
  | while read date; do
  event_printed=false
  echo -n $date
  awk -v start="$(date +'%F')" \
    -v end="$(date -d '+1 weeks' +'%F')" \
    '$1 >= start && $1 < end { print$0 }' events-onetime.txt \
    | while read event; do
    if echo $event | grep -qE "$date_pattern"; then
      event_date=$(echo $event | grep -oE "$date_pattern")
      padding=""
    elif echo $event | grep -qE "$week_pattern"; then
      event_date=$(echo $event | grep -oE "$week_pattern")
      padding="    "
    fi
    if [[ $date == $event_date ]]; then
      event_description_position=$(("${#event_date}" + 1))
      event_description="${event:$event_description_position}"
      if [ "$event_printed" = true ]; then
        echo -n "; $event_description"
      else
        echo -n "$padding $event_description"
      fi
      event_printed=true
    fi
  done
  awk '{ print$0 }' events-recurring.txt \
    | while read event; do
    if echo $event | grep -qE "^[0-9]{2}-[0-9]{2} "; then
      event_date=$(echo $event | grep -oE "^[0-9]{2}-[0-9]{2} ")
      if [[ $date == *"$event_date"* ]]; then
        event_description_position=$(("${#event_date}" + 1))
        event_description="${event:6}"
        if [ "$event_printed" = true ]; then
          echo -n "; $event_description"
        else
          echo -n " $event_description"
        fi
        event_printed=true
      fi
    fi
    if echo $event | grep -qE "^[0-9](,[0-9])* "; then
      event_recurring=$(echo $event | grep -oE "^[0-9](,[0-9])* ")
      echo $event_recurring \
        | grep -o "[0-9]" \
        | while read event_weekday; do
          if [[ $date =~ "$event_weekday"$ ]]; then
            event_description_position=$(("${#event_recurring}"))
            event_description="${event:event_description_position}"
            if [ "$event_printed" = true ]; then
              echo -n "; $event_description"
            else
              echo -n " $event_description"
            fi
            event_printed=true
          fi
      done
    fi
  done
  echo
done

# echo "2024-05-12 w19 Sun xx" | grep -E "$date_pattern"
# echo "2024-05-12 w19 xx" | grep -E "$week_pattern"
# echo "1,2,3 1" | grep -oE "^[0-9](,[0-9])*"
