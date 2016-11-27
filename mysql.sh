#!/bin/bash
USER="root"
#PASWD="aria4768506"

#service mysql stop
#nohup mysqld_safe --skip-slave-start > /dev/null &

#echo "Enter password for mysql:"

#read pass

mysql -u $USER -p << EOF
use mysql;
show tables;
EOF

