#!/usr/bin/env bash
set -e
read -p "Node id (number, start from 0) = " id
if ! [[ "$id" == ?(-)+([0-9]) ]]; then
  echo "error: Not a number" >&2
  exit 1
fi

LIMIT=3
if [[ "$id" -le "$LIMIT" ]]; then
  iptables -F
  # https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands
  iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
  iptables -A INPUT -p icmp -j ACCEPT
  iptables -A OUTPUT -p icmp -j ACCEPT
  is_offline=0
  while true; do
    if [ "$is_offline" -eq 0 ]; then
      iptables -P INPUT DROP
      iptables -P FORWARD DROP
      iptables -P OUTPUT DROP
      is_offline=1
      echo "[$id] offline"
      sleep 10s
    else
      iptables -P INPUT ACCEPT
      iptables -P FORWARD ACCEPT
      iptables -P OUTPUT ACCEPT
      is_offline=0
      echo "[$id] online"
      sleep 5s
    fi
  done
fi
