#!/bin/bash
#
# A tool to run heartbleed scans (using nmap) against hosts parsed with: parse-nmapdata.pl
# Awfully written by: Mike Harris <MikeDawg@gmail.com>
# Version: .001
#
# 
#echo "Please provide filename for data (parsed with parse-nmapdata.pl):  "
read -e -p "File Name (parsed with parse-nmapdata.pl) :  " -i "/tmp/output.txt" userInputFile
read -e -p "Output file for nmap: " -i "/tmp/output.xml" userOutputFile
#
#
IFS=$'\n'
#
for LINE in $(cat ${userInputFile}); do
	ipAdd=$(echo ${LINE} | awk '{print $2}')
	portScanList=$(echo ${LINE} | awk '{print $1}')
	nmap -sV --script +ssl-heartbleed --append-output -oX ${userOutputFile} -Pn ${portScanList} ${ipAdd}
done
