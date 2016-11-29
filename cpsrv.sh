#!/bin/bash

#SIZE=$(fdisk -l | grep Disk | grep -v "identifier" | cut -d' ' -f5)
SIZE=$(parted -l | grep Disk | grep dev | awk '{if (int($3) >= 20) print "BIG"; else print "SMALL"}')
DISK$=$(parted -l | grep Disk | grep dev | awk 'gsub(/\:/,""){print $2}')
echo $SIZE $DISKS


install_func () {
    wget some_source_files && configure && make && make install
}
export -f install_func
chroot "$chrooted_dir" /bin/bash -c "install_func"

