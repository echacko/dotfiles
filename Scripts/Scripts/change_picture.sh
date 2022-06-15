#! /usr/bin/bash
#
#
# Script to change wallpaper, i3lock picture and
# lightdm background picture.

# Set the display
export DISPLAY=:0

# Image directory
PIC_DIR=/home/ebin/Pictures/Wallpapers

# Now set the wallpaper
image_file=$(ls -1 $PIC_DIR/ | sort -R | tail -1)
feh --bg-fill $PIC_DIR/$image_file

# Link a random picutres for i3lock and lightdm
image_file=$(ls -1 $PIC_DIR/ | sort -R | tail -1)

# Convert file to png
convert $PIC_DIR/$image_file $PIC_DIR/lockNlogin.png

cp -f $PIC_DIR/lockNlogin.png /usr/share/backgrounds/.
betterlockscreen -u $PIC_DIR --display 1 2>&1 &

exit 0

