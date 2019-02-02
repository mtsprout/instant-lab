#!/bin/bash

# This script is called from Vagrant, with the hostname and IP address as parameters.

FULLHOST=$2
SHORT_HOST=$(echo $2 | awk -F . '{print $1}')

# Quick entry for /etc/hosts
sed -i -e '1d' /etc/hosts
echo "192.168.55.4    master.vm master puppet" >> /etc/hosts
echo -e "$1    \t$FULLHOST\t\t$SHORT_HOST" >> /etc/hosts

# Install agent
curl -k https://master.vm:8140/packages/current/install.bash | bash


