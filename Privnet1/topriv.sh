#!/bin/bash

# Exit if any of the intermediate steps fail
set -e
i=0
clusters=()
# find the cluster
clusters+=(`aws --profile Pub1 --region eu-west-2 eks list-clusters | jq .clusters[] --compact-output`)
#for j in `aws --region eu-west-2 eks list-clusters | jq .clusters[]`; do
#echo "j=$j"
#clusters+=($j)
#done
nc=${#clusters[@]}

echo "array size=$nc"
#echo ${clusters[0]}
#echo ${clusters[1]}

if [ $nc != "1" ]; then
echo "pick cluster"
exit
else
echo "cluster = ${clusters[0]}"
fi

