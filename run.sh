#!/bin/bash

usage="
$(basename "$0") [-h] [-f file_name] [-a log_amount=1] [-s sleep_time=0]

where:
    -h  show this help text
    -f  file name
    -a  log amount (default:1)
    -s  sleep time (default:0)
	
info: file will be written into /var/log/[file_name]"

logAmount=1
sleepTime=0
fileName=""

outputFileName="run.sh.output.log"

while getopts ":h:f:a:s:" o; do
  case "${o}" in
    h) 
	   echo "$usage" 1>&2;
       exit 1;
       ;;
	f) 
	   fileName=$OPTARG
       ;;
	a) 
	   logAmount=$OPTARG
       ;;
    s)
	   sleepTime=$OPTARG
       ;;
	*)
	   echo "$usage" 1>&2;
       exit 1;
       ;;
  esac
done
shift $((OPTIND-1))

if [ -z "${fileName}" ]; then
	echo "$usage" 1>&2;
    exit 1;
fi

echo "fileName=${fileName}, logAmount=${logAmount}, sleepTime=${sleepTime}" >> $outputFileName

echo "Started at "`date +"%Y-%m-%d %T"` | tee -a $outputFileName
filename="/var/log/${fileName}"
alphabet="abcdefghijklmnopqrstuvwxyz"
for((i=0;i<$logAmount;i+=1)); do
  randomChar=${alphabet:$(( RANDOM % ${#alphabet} )):3}
  url="${randomChar}.com"
  ip=$(printf "%d.%d.%d.%d\n" "$((RANDOM % 256 ))" "$((RANDOM % 256 ))" "$((RANDOM % 256 ))" "$((RANDOM % 256 ))")
  date=" - - ["`date +%d/%m/%Y:%H:%M:%S`"]"
  text=$ip$date'"GET '$url' HTTP/1.1" 304 0 304 0 0 0 655 456 645 368 0'
  echo $text >> $filename
  sleep $sleepTime
done
echo "${filename} > ${logAmount} sample log appended!" | tee -a $outputFileName
echo "Finished at "`date +"%Y-%m-%d %T"` | tee -a $outputFileName
echo >> $outputFileName