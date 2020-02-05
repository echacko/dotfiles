#!/bin/bash

# Change to arcix directory
cd /media/Data/builds/arxiv-sanity-preserver/

# Activate conda arxiv env
source /home/echacko/anaconda3/bin/activate arxiv

# Now run the scripts in order
python fetch_papers.py
python download_pdfs.py
python parse_pdf_to_text.py
python thumb_pdf.py
python analyze.py
python buildsvm.py
python make_cache.py

exit 0
