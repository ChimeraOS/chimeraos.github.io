# fetch_latest_iso.yml
# Author: D.A.Pelasgus

name: Fetch Latest ISO Download Link

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  fetch-latest-iso:
    runs-on: ubuntu-latest

    env:
      REPO: "${{ env.REPO || 'chimeraos/install-media' }}"
      OUTPUT_FILE: "${{ env.OUTPUT_FILE || 'output/latest_iso_url.txt' }}"
      MUSTACHE_FILE: "${{ env.MUSTACHE_FILE || 'src/download.mustache' }}"

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Make fetch_latest_iso.sh executable
      run: chmod +x scripts/fetch_latest_iso.sh

    - name: Run shell script to fetch ISO download link
      env:
        REPO: ${{ env.REPO }}
        OUTPUT_FILE: ${{ env.OUTPUT_FILE }}
      run: ./fetch_latest_iso.sh

    - name: Load download link into environment
      run: echo "DOWNLOAD_LINK=$(cat .iso_download.env | grep ISO_URL | cut -d '=' -f2)" >> $GITHUB_ENV

    - name: Insert download link into Mustache file
      run: sed -i "s|{{downloadLink}}|$DOWNLOAD_LINK|g" "${{ env.MUSTACHE_FILE }}"
