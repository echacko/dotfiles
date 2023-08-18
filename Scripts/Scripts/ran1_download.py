#! /usr/bin/env python3

import argparse
import sys
import urllib.request
from tqdm import tqdm

def download_file(meeting_id, doc_num):
    url = f"https://www.3gpp.org/ftp/TSG_RAN/WG1_RL1/TSGR1_{meeting_id}/Docs/{doc_num}.zip"
    filename = f"{doc_num}.zip"

    try:
        with tqdm(unit='B', unit_scale=True, unit_divisor=1024, miniters=1, desc=f"Downloading {filename}") as t:
            urllib.request.urlretrieve(url, filename, reporthook=download_progress_hook(t))
        print("File downloaded successfully!")
    except Exception as e:
        print(f"URL: {url} is invalid: {e}.")
        url = f"https://www.3gpp.org/ftp/TSG_RAN/WG1_RL1/TSGR1_{meeting_id}/Inbox/{doc_num}.zip"
        print(f"Trying Inbox link: {url}")
        try:
            with tqdm(unit='B', unit_scale=True, unit_divisor=1024, miniters=1, desc=f"Downloading {filename}") as t:
                urllib.request.urlretrieve(url, filename, reporthook=download_progress_hook(t))
            print("File downloaded successfully!")
        except Exception as e:
            print(f"URL: {url} is invalid: {e}.")
            print("Please check the meeting ID and TDoc number.")
            usage()
            exit(255)

def download_progress_hook(t):
    def update_to(b=1, bsize=1, tsize=None):
        if tsize is not None:
            t.total = tsize
        t.update(b * bsize - t.n)
    return update_to

def usage():
    print("Usage: python ran1_download.py <meeting_id> <tdoc_number>")
    print("Usage: python ran1_download.py --bulk <meeting_id> <file_name>")
    exit(255)

# Main
if __name__ == "__main__":
    # Get file name and meeting
    parser = argparse.ArgumentParser(description='Download documents from 3GPP.')
    parser.add_argument('meeting_id', type=str, help='Meeting ID')
    parser.add_argument('--bulk', metavar=('FILE'), nargs=1, help='Download documents in bulk')
    parser.add_argument('tdoc_id', type=str, nargs='?', help='Document number')

    args = parser.parse_args()
    meeting_id = args.meeting_id

    if args.bulk:
        file_path = args.bulk[0]
        print(f"Downloading documents from file '{file_path}'")

        try:
            with open(file_path, 'r') as file:
                tdoc_ids = file.read().splitlines()
        except FileNotFoundError:
            print(f"Error: File '{file_path}' not found.")
            sys.exit(1)

        for tdoc_id in tdoc_ids:
            download_file(meeting_id, tdoc_id)
    else:
        if not args.tdoc_id:
            usage()

        tdoc_id = args.tdoc_id
        download_file(meeting_id, tdoc_id)

    exit(0)
    # Fin
