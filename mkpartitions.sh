#!/bin/bash

RAID="0"
SIZE="small"
USERNAME="imaterinko"

make_small_disk () {
echo "mk_small_disk"
	disk=$1
	parted -s $disk mklabel gpt 
    parted -s $disk mkpart primary 1049kB 2097kB
    parted -s $disk set 1 bios_grub
    parted -s $disk mkpart primary 4096s 18G
    parted -s $disk mkpart primary 18G 100%
	parted -s $disk p
}

make_big_disk () {
	echo "mkbigdisk"
	disk=$1
	parted -s $disk mklabel gpt 
    parted -s $disk mkpart primary 1049kB 2097kB
    parted -s $disk set 1 bios_grub
    parted -s $disk mkpart primary 4096s 18G
    parted -s $disk mkpart primary 18G 100%
	parted -s $disk p
}

make_small_raid () {
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md0 "${1}2" "${2}2"
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md1 "${1}3" "${2}3"
	make_small_fs
}

make_big_raid () {
	echo "mkbigraid"
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md0 "${1}2" "${2}2"
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md1 "${1}3" "${2}3"
	make_big_fs
}

make_small_fs () {
	echo "mksmallfs"
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1

}

make_big_fs () {
	echo "mkbigfs"
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1
	mkfs -t ext4 -L homefs /dev/md2
	mkfs -t ext4 -L varfs /dev/md3
}

replace_all () {
    chroot /mnt /bin/bash -x <<'EOF'
    sed -i -e /ARRAY/d /etc/mdadm/mdadm.conf
    mdadm --examine --scan >> /etc/mdadm/mdadm.conf

    netfile="/etc/network/interfaces"
    netcardsfile="/etc/udev/rules.d/70-persistent-net.rules"
    extif=$(ip route show | awk '/default/{print $5}')
    newaddr=$(ifconfig $extif | awk -F ' *|:' '/inet addr/{print $4}')
    newmac=$(ifconfig $extif | awk '/HWaddr/{print $5}')
    newmask=$(ifconfig $extif | awk -F ' *|:' '/inet addr/{print $8}')
    newgw=$(ip route show | awk '/default/{print $3}')

    sed -i "/iface $extif/!b;:x;n;s/address.*/address $newaddr/;t;/iface/b;bx" $netfile
    sed -i "/iface $extif/!b;:x;n;s/netmask.*/netmask $newmask/;t;/iface/b;bx" $netfile
    sed -i "/iface $extif/!b;:x;n;s/gateway.*/gateway $newgw/;t;/iface/b;bx" $netfile
    sed -E -i "/eth0/s/[0-9a-fA-F:]{17}/$newmac/" $netcardfile

    update-initramfs -u -v -k 3.13.0-93-generic
    grub-install --recheck /dev/sda
    update-grub
    grub-install --recheck /dev/sdb
    update-grub
EOF
}


if [[ $RAID == "1" ]];
    then
    echo "Enter first disk path:"
    read DISK

    if [[ $SIZE == "BIG" ]];
    then
	    make_big_disk $DISK
	    make_big_fs
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
	    make_big_disk $DISK1
	    make_big_disk $DISK2
	    make_big_raid ${DISK1} ${DISK2}
    else
	    make_small_disk $DISK1
	    make_small_disk $DISK2
	    make_small_raid ${DISK1} ${DISK2}
    fi
fi

mount LABEL=rootfs /mnt/

df -h
mdadm --examine --scan


ssh ${USERNAME}@eu5.wormax.io "sudo tar --sparse --one-file-system -C / -czf - ." | tar -C /mnt/ -xzf - .

mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /sys /mnt/sys
mount --bind /proc /mnt/proc

df -h

replace_all

umount --bind /dev /mnt/dev
umount --bind /dev/pts /mnt/dev/pts
umount --bind /sys /mnt/sys
umount --bind /proc /mnt/proc

#reboot

