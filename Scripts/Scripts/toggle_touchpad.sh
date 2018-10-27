#! /usr/bin/bash
#
# Disable/enable the touchpad.
#

# Get the touchpad ID
tid=$(xinput | sed -nre '/[Tt]ouch[Pp]ad/s/.*id=([0-9]*).*/\1/p')

# Chekc if tid is sed
if [ -z $tid ]
then
    echo $tid
    notify-send "Touchpad Not Found!!"
    exit 255
fi

# Get the status of the device
status=$(xinput list-props 11 | grep  'Device Enabled' | cut -d: -f2)

# Enable or disable based on status
if [ $status -eq 1 ]    # Currently enabled
then
    xinput --disable $tid; notify-send "Touchpad Disabled"
else
    xinput --enable $tid; notify-send "Touchpad Enabled"
fi

# Fin
