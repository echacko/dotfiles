#! /usr/bin/bash
#
# This is wrapper script for xdg-open.
# This will run command in bg.

[ $# -ne 1 ] && { 
	echo "Usage : xo filename"
	exit 1
}

[ ! -f "$@" ] && {
	echo "xdg-open: file '$@' does not exist."
	exit 1
}

xdg-open "$@" 1>/dev/null 2>&1 &
