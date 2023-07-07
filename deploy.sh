#!/usr/bin/env bash
set -e

NODE_IPS=()
source ./nodes-config.sh

count=${#NODE_IPS[@]}

#read -p "Node count = " count
#if ! [[ "$count" == ?(-)+([0-9]) ]]; then
#  echo "error: Not a number" >&2
#  exit 1
#fi

node_addresses=()
node_net_addresses=()
START=0
END="$((count - 1))"
echo "Generating $count node accounts..."

chmod +x ./output/bin/*

mkdir -p ./nodes/

i="$START"
while [[ "$i" -le "$END" ]]; do
  echo "====($i/$END)===="
  echo "IP: ${NODE_IPS[$i]}"
  rm -r ./nodes/node-$i || true
  cp -r ./output/ ./nodes/node-$i # the behavior is different depending on whether the target exists
  rm -r ./nodes/node-$i/data/keys || true
  rm -r ./nodes/node-$i/data/netkeys || true
  (cd ./nodes/node-$i && ./bin/xchain-cli account newkeys)
  (cd ./nodes/node-$i && ./bin/xchain-cli netURL gen)
  node_addresses+=("$( (cd ./nodes/node-$i && cat ./data/keys/address))")
  node_net_addresses+=("$( (cd ./nodes/node-$i && ./bin/xchain-cli netURL preview) | sed 's/127.0.0.1/'"${NODE_IPS[$i]}"'/g')")
  echo "Address: ${node_addresses[$i]}".
  echo "Address: ${node_net_addresses[$i]}"
  ((i = i + 1))
done

bash gen-genesis.sh "${node_addresses[@]}" >./nodes/genesis.json

i="$START"
while [[ "$i" -le "$END" ]]; do
  echo "====($i/$END)===="
  (cd ./nodes/node-$i && echo "bootNodes:" >>./conf/network.yaml)
  for addr in "${node_net_addresses[@]}"; do
    (cd ./nodes/node-$i && echo '  - ''"'"$addr"'"' >>./conf/network.yaml)
  done
  sed -i \
    -e 's;^address:.*;address: /ip4/0.0.0.0/tcp/47101;' \
    ./nodes/node-$i/conf/network.yaml
  cp ./nodes/genesis.json ./nodes/node-$i/data/genesis/xuper.json

  rm -r ./nodes/node-$i/logs/* || true
  rm -r ./nodes/node-$i/tmp/* || true

  tar -cf ./nodes/node-$i.tar -C ./nodes/node-$i .

  ((i = i + 1))
done

i="$START"
while [[ "$i" -le "$END" ]]; do
  scp -i ~/.ssh/xuperchain_ecdsa -o StrictHostKeychecking=no {_start-node.sh,_stop-node.sh,_check-node.sh,_block-network.sh} "$USERNAME@${NODE_IPS[$i]}:~/" &
  sleep 0.1s
  ((i = i + 1))
done
wait
