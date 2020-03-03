#!/bin/sh
# This is for dpms control for i3lock
# From dmps blog
# To put the display to standby after 100 seconds,
# to suspend after 200 seconds, and turn it off after 300 seconds,
#  run xset dpms 100 200 300
revert() {
	xset dpms 0 0 0
}
trap revert SIGHUP SIGINT SIGTERM
xset +dpms dpms 10 20 30
# i3lock -n -i $HOME/.i3/images/lock.png -c '#000000' -o '#191d0f' -w '#572020' -l '#ffffff' -e
betterlockscreen -t "GGMU" -l
revert
