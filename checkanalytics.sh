#!/bin/sh

// USAGE checkanalytics.sh <file> where file is textfile with one url per line
IFS=$'\r\n' XYZ=($(cat $1))

for var in "${XYZ[@]}"
do
	printf ${var}
	
	resp=$(curl -sL $var)
	if [[ "$resp" =~ _gaq|google-analytics ]] ; then 
		printf "\t\033[31mANALYTICS\033[39m "
	elif [[ "$resp" =~ ga.js|Analytics|analytics ]]; then
		printf "\t\033[31mGA.JS\033[39m "	
	elif [[ "$resp" =~ webtrends|WebTrends ]]; then
		printf "\t\033[31mWEBTRENDS\033[39m "	
	elif [[ "$resp" =~ piwikTracker ]]; then
		printf "\t\033[31mPIWIK\033[39m "	
		
	else
		printf "\t\033[32mNO\033[39m"	
	fi
	echo 
done
