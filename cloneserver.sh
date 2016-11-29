#!/bin/bash

username="imaterinko"



ssh eu5.wormax.io “tar --sparse --one-file-system -C / -czf - .” | tar -C /mnt/ -xzf - .

mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /sys /mnt/sys
mount --bind /proc /mnt/proc


sed -i -e /ARRAY/d /etc/mdadm/mdadm.conf
mdadm --examine --scan >> /etc/mdadm/mdadm.conf

update-initramfs -u -v -k 3.13.0-93-generic

grub-install --recheck /dev/sda
update-grub
grub-install --recheck /dev/sdb
update-grub
exit

mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /sys /mnt/sys
mount --bind /proc /mnt/proc
