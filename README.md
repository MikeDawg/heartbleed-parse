heartbleed-parse
================

Scripts to work with nmap/masscan in regards to the heartbleed vulnerability

-------------------
The reason I wrote these scripts, is because I was having difficulty in getting NMap to scan just the open TCP ports for the heartbleed vulnerability.

These scripts could possibly be completely unnecessary if your NMap-fu is better than mine, and you are able to properly script these commands out in NMap.

The order of operations is as follows:

run NMap, and have the output go to an XML file of your choice ( -oX ).

Parse that said output with parse-nmapdata.pl
Depending on whether you want to do a masscan check or an nmap check of the open tcp ports found in the nmap scan, you can run either parse-masscan.sh or parse-nmap.sh