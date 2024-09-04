#!/bin/bash

# Check if a domain is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1

# Perform nmap scan
nmap -Pn $DOMAIN
