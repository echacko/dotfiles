#! /usr/bin/bash
#
# This script is for the cron job that updates the pacman mirrorlist 
# everyday.
# The file is only updated when there are changes to the existing mirrorlist.

# First uncomment all the server in pacnew file.
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.pacnew

# Now rank all the mirrors.
rankmirrors -n 10 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist.tmp

# Check if there are any changes in the updated mirrorlist.
diff /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.tmp > /dev/null && { 
    # The new file has no changes. So delete the updated file.
    rm -f /etc/pacman.d/mirrorlist.tmp
} || {
    # There are changes in the updated mirrorlist. 
    # Replace it with the new one.
    mv -f /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
    mv -f /etc/pacman.d/mirrorlist.tmp /etc/pacman.d/mirrorlist
}

# Now exit.
exit 0

