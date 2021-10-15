
#!/bin/bash

# Change to arcix directory
cd /media/Data/builds/arxiv-sanity-preserver/

# Activate conda arxiv env
source /home/echacko/anaconda3/bin/activate /media/Data/builds/arxiv-sanity-preserver/arxiv

# Start mongo db
sudo systemctl start mongodb.service

python serve.py --prod --port 8080
