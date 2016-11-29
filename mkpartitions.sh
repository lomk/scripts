#!/bin/bash

RAID="0"
SIZE="small"

function mk_small_disk() {
	disk=$1
	parted -s $disk mklabel gpt 
    	parted -s $disk mkpart primary 1049kB 2097kB
    	parted -s $disk set 1 bios_grub
    	parted -s $disk mkpart primary 4096s 18G
    	parted -s $disk mkpart primary 18G 100%
	parted -s $disk p
}

function mk_big_disk() {
	disk=$1
	parted -s $disk mklabel gpt 
    	parted -s $disk mkpart primary 1049kB 2097kB
    	parted -s $disk set 1 bios_grub
    	parted -s $disk mkpart primary 4096s 18G
    	parted -s $disk mkpart primary 18G 100%
	parted -s $disk p
}

function mk_small_raid() {
	disk1=$1
	disk2=$2
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md0 ${disk1}2 ${disk1}2
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md1 ${disk1}3 ${disk1}3
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1
	mk_small_fs
}


function mk_big_raid() {
	disk1=$1
	disk2=$2
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md0 ${disk1}2 ${disk1}2
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md1 ${disk1}3 ${disk1}3
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1
	mk_big_fs

}

function mk_small_fs () {
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1
	mkfs -t ext4 -L homefs /dev/md2
	mkfs -t ext4 -L varfs /dev/md3
}
function mk_big_fs () {
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1
	mkfs -t ext4 -L homefs /dev/md2
	mkfs -t ext4 -L varfs /dev/md3
}





if [[ $RAID == "1" ]];
    then
    echo "Enter first disk path:"
    read DISK

    if [[ $SIZE == "BIG" ]];
    then
	mk_big_disk $DISK
	mk_big_fs
    else
	mk_small_disk $DISK
	mk_small_fs
    fi
else
    echo "Enter first disk path:"
    read DISK1
    echo "Enter second disk path:"
    read DISK2

    if [[ $SIZE == "BIG" ]];
    then
	mk_big_disk $DISK1
	mk_big_disk $DISK2
	mk_big_raid $DISK1 $DISK2
    else
	mk_small_disk $DISK1
	mk_small_disk $DISK2
	mk_small_raid $DISK1 $DISK2
    fi
fi

mount LABEL=rootfs /mnt/



