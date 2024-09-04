#!/bin/bash

# Check if a domain is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1

# Run subfinder
subfinder -d $DOMAIN
