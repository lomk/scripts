#!/bin/bash

clear
while (true)
do 
    echo -e "iostat output\n"
    echo -e "Device:\t\ttps\t\tkB_read/s\tkB_wrtn/s\tkB_read\t\tkB_wrtn"
    iostat | awk -v OFS='\t\t' '/Dev/ {getline; print $1, $2, $3, $4, $5, $6}'
    sleep 1
clear
done