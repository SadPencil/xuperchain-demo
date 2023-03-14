#!/usr/bin/env bash
set -e

USERNAME=ubuntu
NODE_IPS=()
source ./nodes-config.sh

count=${#NODE_IPS[@]}
START=0
END="$((count - 1))"

i="$START"
while [[ "$i" -le "$END" ]]; do
  echo "echo $i | bash _start-node.sh" | ssh -i ~/.ssh/xuperchain_ecdsa -o StrictHostKeychecking=no "$USERNAME@${NODE_IPS[$i]}" &
  sleep 0.1s
  ((i = i + 1))
done
wait
