# fetch_latest_iso.yml
# Author: D.A. Pelasgus

name: Fetch Latest ISO Download Link

on:
  push:
    branches:
      - master
  workflow_dispatch:

jobs:
  fetch-latest-iso:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Make fetch_latest_iso.sh executable
      run: chmod +x scripts/fetch_latest_iso.sh

    - name: Run shell script to fetch ISO download link
      env:
        REPO: "chimeraos/install-media"
        OUTPUT_FILE: "output/latest_iso_url.txt"
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      run: ./scripts/fetch_latest_iso.sh

    - name: Load download link into environment
      run: |
        if [ -f ".iso_download.env" ]; then
          echo "DOWNLOAD_LINK=$(grep 'ISO_URL' .iso_download.env | cut -d '=' -f2)" >> $GITHUB_ENV
        else
          echo "Error: .iso_download.env file not found."
          exit 1
        fi

    - name: Insert download link into Mustache file
      env:
        DOWNLOAD_LINK: ${{ env.DOWNLOAD_LINK }}
        MUSTACHE_FILE: "src/download.mustache"
      run: sed -i "s|{{downloadLink}}|$DOWNLOAD_LINK|g" "$MUSTACHE_FILE"

    - name: Verify updated Mustache file
      run: cat src/download.mustache
