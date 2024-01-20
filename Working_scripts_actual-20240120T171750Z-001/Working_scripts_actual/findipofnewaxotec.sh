#!/bin/bash

# Axotec vendor prefixes to search for
MAC_PREFIXES="b8:27:eb\|dc:a6:32\|e4:5f:01"

# Ping broadcast to update arp table
ping -c 2 172.16.1.255 -b

# Get the IP addresses of the present Axotecs and loop through them copying the ssh keys
TARGETS=($(arp -a | grep $MAC_PREFIXES | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])'))
echo "Hosts found:"
echo $TARGETS
echo $TARGETS > /tmp/ipaddress
#for ip in "${TARGETS[@]}"
#do
 #  echo Fetching SSH keys from $ip
  # ssh-keygen -f /root/.ssh/known_hosts -R $ip
  # ssh-copy-id -f root@$ip
#done