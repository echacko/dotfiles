#! /usr/bin/env python3

import sys
import urllib3

ran1_base_url = "https://www.3gpp.org/ftp/TSG_RAN/WG1_RL1/"

# Get file name and meeting
try:
    meeting_id = sys.argv[1]
    tdoc_id = sys.argv[2]
except IndexError:
    print("\nERROR: Please specify Meeting ID and TDoc number.")
    print("Usage python ran1_download.py <meeting_id> <tdoc_number>")

http = urllib3.PoolManager()

ran1_meeting_url = ran1_base_url + "TSGR1_" + meeting_id
ran1_tdoc_url = ran1_meeting_url + "/Docs/" + tdoc_id + ".zip"

response = http.request('GET', ran1_tdoc_url, preload_content=False)

if (response.status != 200):
    print(f"Invalid URL :{ran1_meeting_url}")
    exit(255)

filename = tdoc_id + ".zip"
file_size = int(response.headers["Content-Length"])
chunk_size = 8192
print(f"Downloading {filename} : {file_size}")

with open(filename, 'wb') as out:
    while True:
        data = response.read(chunk_size)
        if not data:
            break
        out.write(data)

response.release_conn()

# Fin
