#!/bin/bash

sed -i -e /ARRAY/d /etc/mdadm/mdadm.conf
mdadm --examine --scan >> /etc/mdadm/mdadm.conf


update-initramfs -u -v -k 3.13.0-93-generic

grub-install --recheck /dev/sda
update-grub
grub-install --recheck /dev/sdb
update-grub

