#!/bin/sh

cat hosts.yml | grep "^\s*ansible_host" | awk '{ print $2 }' | xargs -l ssh-keyscan
