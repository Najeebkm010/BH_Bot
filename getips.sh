#!/bin/bash

DOMAIN="$1"

if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

echo "Fetching IPs for domain: $DOMAIN"
echo

# ---------- 1. Host IPs ----------
echo "[1] Host IPs:"
host "$DOMAIN" | grep "has address" | awk '{print $4}'
echo

# ---------- 2. Favicon IPs ----------
echo "[2] Favicon IPs:"

FAVICON_URL=$(curl -s "https://$DOMAIN" | grep -iEo '<link[^>]+rel="[^"]*icon[^"]*"[^>]*>' | grep -Eo 'href="[^"]+"' | cut -d'"' -f2 | head -n1)

if [[ -z "$FAVICON_URL" ]]; then
  FAVICON_URL="https://$DOMAIN/favicon.ico"
  echo "No favicon link found in HTML, using default: $FAVICON_URL"
else
  [[ $FAVICON_URL == http* ]] || FAVICON_URL="https://$DOMAIN$FAVICON_URL"
  echo "Found favicon URL: $FAVICON_URL"
fi

ENCODED_URL=$(echo "$FAVICON_URL" | jq -s -R -r @uri)
HASH_JSON=$(curl -s "https://favicon-hash.kmsec.uk/api/?url=$ENCODED_URL")

FAVICON_HASH=$(echo "$HASH_JSON" | jq -r '.favicon_hash // empty')

if [[ -z "$FAVICON_HASH" ]]; then
  echo "❌ No favicon hash found."
else
  echo "Favicon hash: $FAVICON_HASH"
  echo "Fetching Shodan page for favicon hash..."

  # Add your actual cookie value here securely
  SHODAN_COOKIE='polito="d5076b8303ac3898d00f2236c40359f9689082286890820b29e5ef7b3d24c457!"'

  # Authenticated request
  curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:141.0) Gecko/20100101 Firefox/141.0" \
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
    -H "Accept-Language: en-US,en;q=0.5" \
    -H "Referer: https://www.shodan.io/search/report?query=http.favicon.hash%3A$FAVICON_HASH" \
    -H "Upgrade-Insecure-Requests: 1" \
    -H "Cookie: $SHODAN_COOKIE" \
    "https://www.shodan.io/search?query=http.favicon.hash%3A$FAVICON_HASH" -o shodan_favicon.html


  echo "IPs from favicon hash search:"
  grep -Po '<li class="hostnames text-secondary">\K[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' shodan_favicon.html | sort -u
fi
echo

# ---------- 3. Wildcard Subdomain IPs ----------
echo "[3] Shodan Hostname Wildcard IPs:"

curl -s -A "Mozilla/5.0" "https://www.shodan.io/search/facet?query=hostname%3A*.$DOMAIN&facet=ip" -o shodan_host.html

grep -Eo '<strong>[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+</strong>' shodan_host.html | cut -d '>' -f 2 | cut -d '<' -f 1 | sort -u

echo
echo "Done ✅"
