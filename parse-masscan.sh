#!/bin/bash
#
# A tool to run heartbleed scans (using masscan) against hosts parsed with: parse-nmapdata.pl
# Awfully written by: Mike Harris <MikeDawg@gmail.com>
# Version: .001
#
#
#
#
read -e -p "File Name (parsed with parse-nmapdata.pl) :  " -i "/tmp/output.txt" userInputFile
read -e -p "Output file for masscan: " -i "/tmp/output.xml" userOutputFile
#
IFS=$'\n'
#
for LINE in $(cat ${userInputFile}); do
	ipAdd=$(echo ${LINE} | awk '{print $2}')
	portScanList=$(echo ${LINE} | awk '{print $1}')
	/usr/local/bin/masscan ${ipAdd} ${portScanList} --rate 1000 --heartbleed --banners --append-output --output-format xml --output-filename ${userOutputFile} 
done
