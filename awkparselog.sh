#!/bin/bash


echo -e "{\n Log entry: {"
awk -F '\\[|\\]|"' \
'{ OFS=":" }\
{print "\t\{"};\
{ for( i = 1; i <= NF; i++ )\
{ gsub(/[-]*/,"",$i);\
gsub(/\s*$/,"",$i);\
gsub(/^\s*/,"",$i);\
gsub(/^\s*$/,"",$i);\
{ if ( $i!=" " || $i!="" )\
#{print ":"$i":"};\
if (i==1) print "\t\"IP\": \""$i"\",";\
else if (i==2) {i1=i2=$i;\
                gsub(/\s\+[0-9]*$/,"",i1);\
                gsub(/^.*\s/,"",i2);\
                print "\t\"TIME\": \""i1"\",";\
                print "\t\"TIMEZONE\": \""i2"\",";}\
#else if (i==3) {print "\t\"3\": \""$i"\""}\
else if (i==4) {i1=i2=i3=$i;\
                gsub(/\s+.*\s+.*$/,"",i1);\
                gsub(/(^[A-Z]*\s?)|(\s[A-Z]*.*$)/,"",i2);\
                gsub(/^.*\s+/,"",i3);\
                print "\t\"Method\": \""i1"\",";\
                print "\t\"URI\": \""i2"\",";\
                print "\t\"PROTO\": \""i3"\",";}\
else if (i==5) {i1=i2=$i;\
                gsub(/\s+.*$/,"",i1);\
                gsub(/^.*\s/,"",i2);\
                print "\t\"STATUS\": \""i1"\",";\
                if ($8!="" && $8!="-") { print "\t\"resptime\": \""i2"\","}\
                else {print "\t\"resptime\": \""i2"\""}}\
else if ($i!="" && i==8) {print "\t\"Client\": \""$i"\""}\
}}}
{print "\t\},"}' /var/log/nginx/access.log 2>/dev/null
echo "}"