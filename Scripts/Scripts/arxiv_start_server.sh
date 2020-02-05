
#!/bin/bash

# Change to arcix directory
cd /media/Data/builds/arxiv-sanity-preserver/

# Activate conda arxiv env
source /home/echacko/anaconda3/bin/activate arxiv

# Start mongo db
sudo systemctl start mongodb.service

python serve.py --prod --port 8080
