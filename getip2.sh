#! /usr/bin/env sh
nmap -sn 172.16.13.0/24 |
    awk '
        function out() { if (state=="up") { printf "%s\t%s\t%s\n",ip,mac,name; ip=""; mac=""; name=""; state="" } }

        /Nmap scan report/ { out(); name=$5; ip = substr($6,2,length($6)-2); if (ip=="") { ip=name; name="" } }
        /Host is/ { state=$3 }
        /MAC Address/ { mac=$3 }

        END { out() }
    '
