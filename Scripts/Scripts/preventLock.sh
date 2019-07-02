#! /usr/bin/bash
#
# Script that prevents the automatic lock by simulating a 
# key press.

echo "Preventing autolock."

while true
do
  xdotool key shift
  sleep 260
done
