#! /usr/bin/bash
# 
# This script will check if we are logged into internet.iitb.ac.in
# This will just check if your IP is logged in by fetching the index.html from the site.


ip=10.107.2.55

wget -O /var/tmp/logged.in https://internet.iitb.ac.in >/dev/null 2>&1


grep -q "$ip" /var/tmp/logged.in && echo 1 || echo 0 
 


rm -f /var/tmp/logged.in

exit 0
