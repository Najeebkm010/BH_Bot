#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1
OUTDIR="result"
OUTFILE="$OUTDIR/$DOMAIN.txt"

mkdir -p $OUTDIR

# Run paramspider
paramspider -d "$DOMAIN"

# Check if output exists
if [ ! -f "$OUTFILE" ]; then
  echo "Paramspider did not create output: $OUTFILE"
  exit 2
fi

# Run kxss on the paramspider output
cat "$OUTFILE" | kxss
