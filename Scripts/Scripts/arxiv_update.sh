#!/bin/bash

# change to arcix directory
cd /media/Data/builds/arxiv-sanity-lite

# activate conda arxiv env
source /home/echacko/anaconda3/bin/activate /media/Data/builds/arxiv-sanity-lite/venv

python3 arxiv_daemon.py --num 2000

if [ $? -eq 0 ]; then
    echo "New papers detected! Running compute.py"
    python3 compute.py
else
    echo "No new papers were added, skipping feature computation"
fi

exit 0
