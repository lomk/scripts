#!/usr/bin/python

import re


def _itersplit(l, splitters):
    current = []
    for item in l:
        if item in splitters:
            yield current
            current = []
        else:
            current.append(item)
    yield current

def magicsplit(l, *splitters):
    return [subl for subl in _itersplit(l, splitters) if subl]

def makedict(l):
    lst = []
    for i in l:
	dct = {}
	for y in i:
	    y = y.split(':')
	    y[0] = re.sub(r'\s', '', y[0])
	    y[1] = re.sub(r'^\s', '', y[1])
	    dct[y[0]] = y[1]
	lst.append(dct)
    return lst



l1 = [
        "", 
        "", 
        "IdentifyingNumber : {26A24AE4-039D-4CA4-87B4-2F64180111F0}", 
        "Name              : Java 8 Update 111 (64-bit)", 
        "Vendor            : Oracle Corporation", 
        "Version           : 8.0.1110.14", 
        "Caption           : Java 8 Update 111 (64-bit)", 
        "", 
        "IdentifyingNumber : {60EC980A-BDA2-4CB6-A427-B07A5498B4CA}", 
        "Name              : Google Update Helper", 
        "Vendor            : Google Inc.", 
        "Version           : 1.3.31.5", 
        "Caption           : Google Update Helper", 
        "", 
        "IdentifyingNumber : {8E34682C-8118-31F1-BC4C-98CD9675E1C2}", 
        "Name              : Microsoft .NET Framework 4 Extended", 
        "Vendor            : Microsoft Corporation", 
        "Version           : 4.0.30319", 
        "Caption           : Microsoft .NET Framework 4 Extended", 
        "", 
        "IdentifyingNumber : {FC6BB9AC-9C76-4B3C-A41A-8E16D4DAA7C0}", 
        "Name              : IT Invent", 
        "Vendor            : YuKoSoft", 
        "Version           : 1.61.0", 
        "Caption           : IT Invent", 
        "", 
        "IdentifyingNumber : {F5B09CFD-F0B2-36AF-8DF4-1DF6B63FC7B4}", 
        "Name              : Microsoft .NET Framework 4 Client Profile", 
        "Vendor            : Microsoft Corporation", 
        "Version           : 4.0.30319", 
        "Caption           : Microsoft .NET Framework 4 Client Profile", 
        "", 
        "IdentifyingNumber : {4A03706F-666A-4037-7777-5F2748764D10}", 
        "Name              : Java Auto Updater", 
        "Vendor            : Oracle Corporation", 
        "Version           : 2.8.111.14", 
        "Caption           : Java Auto Updater", 
        "", 
        "", 
        ""
    ]


l2 = magicsplit(l1, "")

l3 = makedict(l2)
print l3

appname = "Java 8"

for i in l3:
    for n, m in i.iteritems():
	if n == "Name" and m.find(appname) >= 0:
	    print n
	    print m














