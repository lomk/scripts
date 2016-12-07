#!/usr/bin/python

import json
import sys

l = [
        "", 
        "", 
        "DisplayName       : Adobe Flash Player 23 ActiveX", 
        "Publisher         : Adobe Systems Incorporated", 
        "DisplayVersion    : 23.0.0.207", 
        "HelpLink          : http://www.adobe.com/go/flashplayer_support/", 
        "NoModify          : 1", 
        "NoRepair          : 1", 
        "RequiresIESysFile : 4.70.0.1155", 
        "URLInfoAbout      : http://www.adobe.com", 
        "URLUpdateInfo     : http://www.adobe.com/go/getflashplayer/", 
        "VersionMajor      : 23", 
        "VersionMinor      : 0", 
        "UninstallString   : C:\\Windows\\SysWOW64\\Macromed\\Flash\\FlashUtil32_23_0_0_207_A", 
        "                    ctiveX.exe -maintain activex", 
        "DisplayIcon       : C:\\Windows\\SysWOW64\\Macromed\\Flash\\FlashUtil32_23_0_0_207_A", 
        "                    ctiveX.exe", 
        "EstimatedSize     : 4884", 
        "PSPath            : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Soft", 
        "                    ware\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "                    \\Adobe Flash Player ActiveX", 
        "PSParentPath      : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Soft", 
        "                    ware\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "PSChildName       : Adobe Flash Player ActiveX", 
        "PSDrive           : HKLM", 
        "PSProvider        : Microsoft.PowerShell.Core\\Registry", 
        "", 
        "DisplayName       : Adobe Flash Player 23 NPAPI", 
        "Publisher         : Adobe Systems Incorporated", 
        "DisplayVersion    : 23.0.0.207", 
        "HelpLink          : http://www.adobe.com/go/flashplayer_support/", 
        "NoModify          : 1", 
        "NoRepair          : 1", 
        "RequiresIESysFile : 4.70.0.1155", 
        "URLInfoAbout      : http://www.adobe.com", 
        "URLUpdateInfo     : http://www.adobe.com/go/getflashplayer/", 
        "VersionMajor      : 23", 
        "VersionMinor      : 0", 
        "UninstallString   : C:\\Windows\\SysWOW64\\Macromed\\Flash\\FlashUtil32_23_0_0_207_P", 
        "                    lugin.exe -maintain plugin", 
        "DisplayIcon       : C:\\Windows\\SysWOW64\\Macromed\\Flash\\FlashUtil32_23_0_0_207_P", 
        "                    lugin.exe", 
        "EstimatedSize     : 5479", 
        "PSPath            : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Soft", 
        "                    ware\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "                    \\Adobe Flash Player NPAPI", 
        "PSParentPath      : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Soft", 
        "                    ware\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "PSChildName       : Adobe Flash Player NPAPI", 
        "PSDrive           : HKLM", 
        "PSProvider        : Microsoft.PowerShell.Core\\Registry", 
        "", 
        "DisplayName       : Adobe Flash Player 23 PPAPI", 
        "Publisher         : Adobe Systems Incorporated", 
        "DisplayVersion    : 23.0.0.207", 
        "HelpLink          : http://www.adobe.com/go/flashplayer_support/", 
        "NoModify          : 1", 
        "NoRepair          : 1", 
        "RequiresIESysFile : 4.70.0.1155", 
        "URLInfoAbout      : http://www.adobe.com", 
        "URLUpdateInfo     : http://www.adobe.com/go/getflashplayer/", 
        "VersionMajor      : 23", 
        "VersionMinor      : 0", 
        "UninstallString   : C:\\Windows\\SysWOW64\\Macromed\\Flash\\FlashUtil32_23_0_0_207_p", 
        "                    epper.exe -maintain pepperplugin", 
        "DisplayIcon       : C:\\Windows\\SysWOW64\\Macromed\\Flash\\FlashUtil32_23_0_0_207_p", 
        "                    epper.exe", 
        "EstimatedSize     : 19998", 
        "PSPath            : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Soft", 
        "                    ware\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "                    \\Adobe Flash Player PPAPI", 
        "PSParentPath      : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Soft", 
        "                    ware\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "PSChildName       : Adobe Flash Player PPAPI", 
        "PSDrive           : HKLM", 
        "PSProvider        : Microsoft.PowerShell.Core\\Registry", 
        "", 
        "SystemComponent : 1", 
        "PSPath          : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Softwa", 
        "                  re\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Con", 
        "                  nection Manager", 
        "PSParentPath    : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Softwa", 
        "                  re\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "PSChildName     : Connection Manager", 
        "PSDrive         : HKLM", 
        "PSProvider      : Microsoft.PowerShell.Core\\Registry", 
        "", 
        "DisplayName     : Google Chrome", 
        "UninstallString : \"C:\\Program Files (x86)\\Google\\Chrome\\Application\\54.0.2840.9", 
        "                  9\\Installer\\setup.exe\" --uninstall --multi-install --chrome -", 
        "                  -system-level", 
        "InstallLocation : C:\\Program Files (x86)\\Google\\Chrome\\Application", 
        "DisplayIcon     : C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe,0", 
        "NoModify        : 1", 
        "NoRepair        : 1", 
        "Publisher       : Google Inc.", 
        "Version         : 54.0.2840.99", 
        "DisplayVersion  : 54.0.2840.99", 
        "InstallDate     : 20160115", 
        "VersionMajor    : 2840", 
        "VersionMinor    : 99", 
        "PSPath          : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Softwa", 
        "                  re\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Goo", 
        "                  gle Chrome", 
        "PSParentPath    : Microsoft.PowerShell.Core\\Registry::HKEY_LOCAL_MACHINE\\Softwa", 
        "                  re\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall", 
        "PSChildName     : Google Chrome", 
        "PSDrive         : HKLM", 
        "PSProvider      : Microsoft.PowerShell.Core\\Registry", 
        ""
        ]


def parse(dc = [], *args):
    key1 = "DisplayName"
    key2 = "DisplayVersion"
    key3 = "UninstallString"
    DisplayName = 0
    DisplayVersion = 0
    #UnistallString = 0
    maind = []
    lst = []

    for i in dc:
        if i.find(key1) >= 0 and DisplayName == 0:
            lst.append(i)
            DisplayName = 1
        elif  i.find(key1) >= 0 and DisplayName == 1:
            maind.append(lst)
            lst = []
            DisplayName = 1
            DisplayVersion = 0
            lst.append(i)
        if i.find(key2) >= 0 and DisplayName == 1:
            lst.append(i)
            DisplayVersion = 1
        if i.find(key3) >= 0 and DisplayName == 1 and DisplayVersion == 1:
            lst.append(i)
            maind.append(lst)
            lst = []
            DisplayName = 0
            DisplayVersion = 0
    return maind

#print maind
#s = parse(l)
#print s

data = json.load(sys.stdin)
lstr = data[list(data.keys())[0]]

s = parse(lstr)
print s
