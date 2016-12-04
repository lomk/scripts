#!/bin/bash

raid=$(lspci -vv | grep -i raid)
disks=($(fdisk -l | grep -E -i "disk.*dev" | awk 'gsub(/:/,""){print $2}'))
size=$(fdisk ${disks[0]}-l | awk '/^Disk \/dev/ {print $5}')


make_small_disk () {
        parted -s $1 mklabel gpt 
        parted -s $1 mkpart primary 1049kB 2097kB
        parted -s $1 set 1 bios_grub
        parted -s $1 mkpart primary 4096s 18G
        parted -s $1 mkpart primary 18G 100%
	parted -s $1 p
}

make_big_disk () {
        parted -s $1 mklabel gpt 
        parted -s $1 mkpart primary 1049kB 2097kB
        parted -s $1 set 1 bios_grub
        parted -s $1 mkpart primary 4096s 18G
        parted -s $1 mkpart primary 18G 100%
        parted -s $1 p
}

make_small_raid () {
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md0 "${1}2" "${2}2"
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md1 "${1}3" "${2}3"
	mkfs -t ext4 -L rootfs /dev/md0
	mkswap -L swap00 /dev/md1
}

make_big_raid () {
	echo "make big raid"
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md0 "${1}2" "${2}2"
	mdadm --create --metadata=1.2 --level=1 --raid-devices=2 /dev/md1 "${1}3" "${2}3"
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
    disks=($(fdisk -l | grep -E -i "disk.*dev" | awk 'gsub(/:/,""){print $2}'))
    for i in "${disks[@]}"
    do
        grub-install --recheck $i
        update-grub
    done
EOF
}

if [[ $raid ]];
    then
    for i in "${disks[@]}"
    do
        if [[ "$size" > "512000000000" ]];
        then
	    make_big_disk $i
	    make_big_fs
        else
	    make_small_disk $i
	    make_small_fs
        fi
    done
else
    for i in "${disks[@]}"
    do
        if [[ "$size" > "512000000000" ]];
        then
	    make_big_disk $i
        else
	    make_small_disk $i
        fi
    done
    if [[ "$size" > "512000000000" ]];
    then
        make_big_raid ${disks[0]} ${disks[1]}
    else
        make_small_raid ${disks[0]} ${disks[1]}
    fi
fi

mount LABEL=rootfs /mnt/

echo "Enter ssh user to connect:"
read username
ssh ${username}@eu5.wormax.io "sudo tar --sparse --one-file-system -C / -czf - ." | tar -C /mnt/ -xzf - .

mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /sys /mnt/sys
mount --bind /proc /mnt/proc

replace_all

umount --bind /dev /mnt/dev
umount --bind /dev/pts /mnt/dev/pts
umount --bind /sys /mnt/sys
umount --bind /proc /mnt/proc

reboot

