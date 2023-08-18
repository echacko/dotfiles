#! /usr/bin/bash
#
# Script to test the network connection.
#

echo "Pinging localhost."
ping -c 5 127.0.0.1

echo "Pinging gateway."
ping -c 5 10.200.1.25

echo "Pingign 1.1.1.1"
ping -c 5 1.1.1.1

echo "Pinging archlinux.org"
ping -c 5 archlinux.org
