#!/usr/bin/python

import sys
import ldap
import re

con=ldap.initialize('ldap://192.168.1.2:389')

user_dn = r"admin@home.local"
password = "Qwerty123"

criteria = "(&(objectClass=user))"
attributes = ['displayName', 'company']

try:
    con.simple_bind_s(user_dn, password)
    res =con.search_s("DC=home,DC=local", ldap.SCOPE_SUBTREE,'(objectClass=Computer)')
    dc = {}
    for dn, entry in res:
	dn = re.sub(r'.DC.*', '', dn)
	dn = re.sub(r'CN\=', '', dn)
	dn = re.sub(r'OU\=', '', dn)
	dn = dn.split(',')
	dc[dn[1]] = dn[0]
	print dc

except Exception, error:
    print error

