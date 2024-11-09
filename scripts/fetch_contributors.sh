# fetch_contributors.sh
# Authour: D.A.Pelasgus

#!/bin/bash

# Ensure the script is executable
chmod +x fetch_contributors.sh

# Set default values for GitHub organization, HTML file, and GitHub token
ORG="${ORG:-chimeraos}"
HTML_FILE="${HTML_FILE:-src/index.html}"

# Verify that the GitHub token is set
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set."
  exit 1
fi

# Get all repositories in the organization
repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/orgs/$ORG/repos" | grep -oP '"full_name": "\K[^"]+')

# Initialize an empty associative array to store unique contributors
declare -A contributors

# Fetch contributors for each repository
for repo in $repos; do
  repo_contributors=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$repo/contributors" | grep -oP '"login": "\K[^"]+')
  for contributor in $repo_contributors; do
    contributors["$contributor"]=1
  done
done

# Build the contributors HTML list
contributors_html="<h4>Thank you to all our contributors!</h4><p>"
for contributor in "${!contributors[@]}"; do
  contributors_html+="$(echo "$contributor" | sed 's/$/<br>/')"
done
contributors_html+="</p>"

# Replace the existing contributors section in the HTML file
sed -i "/<h4>Thank you to all our contributors!/,/<\/p>/c\\$contributors_html" "$HTML_FILE"

echo "Updated $HTML_FILE with the latest contributors."
