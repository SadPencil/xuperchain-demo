#!/usr/bin/env bash
set -e
SERVER="172.17.16.12:8080"

read -p "Node id (number, start from 0) = " id
if ! [[ "$id" == ?(-)+([0-9]) ]]; then
  echo "error: Not a number" >&2
  exit 1
fi
rm ./node-$id.tar || true
rm -r ./xuperchain || true
mkdir ./xuperchain
wget "http://$SERVER/node-$id.tar"
tar -xf node-$id.tar -C ./xuperchain
cd ./xuperchain
exec bash control.sh start
