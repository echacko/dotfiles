
#!/bin/bash

# change to arcix directory
cd /media/Data/builds/arxiv-sanity-lite

# activate conda arxiv env
source /home/echacko/anaconda3/bin/activate /media/Data/builds/arxiv-sanity-lite/venv

python serve.py --prod --port 8080

export FLASK_APP=serve.py; flask run --port 8080
