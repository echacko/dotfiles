#!/bin/bash
# 
# Script to edit mp3 file tags

dir=$1
for song in $(find $dir -type f -name "*mp3"); do
    title=$(basename $song | cut -d )
