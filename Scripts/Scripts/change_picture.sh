#! /usr/bin/bash
#
#
# Script to change wallpaper, i3lock picture and
# lightdm background picture.

# Set the display
export DISPLAY=:0

# Image directory
PIC_DIR=/home/echacko/Pictures/Wallpapers

total=$(ls -1 $PIC_DIR | wc -l)    # Total number of images

# Link a random picutres for i3lock and lightdm
file_num=$((RANDOM % total))
image_file=$(ls -1 $PIC_DIR/ | sed -n "$file_num p")

cp -f $PIC_DIR/$image_file /usr/share/pixmaps/login.png
cp -f $PIC_DIR/$image_file /home/echacko/.i3/images/lock.png

# Now set the wallpaper
feh --randomize --bg-fill $PIC_DIR/*

exit 0

