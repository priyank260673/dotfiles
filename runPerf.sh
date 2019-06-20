#!/bin/bash
echo "Processing file $1"

grep METRIC $1 | grep RouterSubmit | grep cfeboerouter > /tmp/tempData.txt

# First first 10 bad entries
cat /tmp/tempData.txt | awk -F"queue_read_time: " '{print $2}' | sed 's/, queue_commit_time: .*//' | awk -F", wire_write_time: " '{print $2-$1 "\t" $2 "\t" $1}'  | sort -nr | head -10

# Print min,max,avg
cat  /tmp/tempData.txt | awk -F"queue_read_time: " '{print $2}' | sed 's/, queue_commit_time: .*//' | awk -F", wire_write_time: " '{print $2-$1 "\t" $2 "\t" $1}' |  awk '{if(min==""){min=max=$1}; if($1>max) {max=$1}; if($1<min) {min=$1}; total+=$1; count+=1} END {print "avg " total/count," | max "max," | min " min " | samples " NR}'
