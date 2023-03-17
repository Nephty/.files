#!/bin/bash

wifi_ssid=$(iwgetid -r)
if [ -z "$wifi_ssid" ]; then
  echo "    offline"
  exit
fi

ping_result=$(ping -c 1 -w 2 1.1.1.1)

if [[ $ping_result == *"Destination Port Unreachable"* ]]; then
    echo "    offline"
    exit
fi

ping_result=$(ping -c 1 -w 2 1.1.1.1 | awk -F'/' 'END{print $5}')

if [ -n "$ping_result" ]; then
  delay=$(printf "%.0f" $ping_result)

  if [ ${#delay} -eq 1 ]; then
    printf "      %d ms\n" $delay
  elif [ ${#delay} -eq 2 ]; then
    printf "    %d ms\n" $delay
  elif [ ${#delay} -eq 3 ]; then
    printf "%d ms\n" $delay
  else
    printf "%d ms\n" $delay
  fi
else
  echo "      high"
fi

