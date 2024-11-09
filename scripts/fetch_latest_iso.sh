# fetch_latest_iso.sh
# Author: D.A.Pelasgus
#!/bin/bash

# Variables for repository and output file with directory fallback
REPO="${REPO:-chimeraos/install-media}"
OUTPUT_FILE="${OUTPUT_FILE:-latest_iso_download_url.txt}"

# Fetch the latest release data from the GitHub API
response=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Check if the response contains assets and find an ISO asset
iso_url=$(echo "$response" | jq -r '.assets[] | select(.name | endswith(".iso")) | .browser_download_url')
iso_name=$(echo "$response" | jq -r '.assets[] | select(.name | endswith(".iso")) | .name')

# Verify if an ISO file was found
if [[ -n "$iso_url" ]]; then
  echo "ISO file found: $iso_name"
  echo "Download URL: $iso_url"

  # Save the download link to the output file
  echo "$iso_url" > "$OUTPUT_FILE"
else
  echo "Error: ISO file not found in the latest release."
  exit 1
fi
