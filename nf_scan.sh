#!/bin/bash

# Check if a domain is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1

# Run nf with the provided domain
nf -d "$DOMAIN"
