#!/bin/bash

FILES=$(az storage blob list  \
  --account-name cdscostmgmtreports \
  --container-name exports )

# exit
# Get the latest version of the report
FILE=$(echo "$FILES"| \
  jq -r ". |= sort_by(.properties.lastModified) | .[].name" \
  | tail -n 1)

echo "$FILE"

echo "Downloading $FILE"

# Download the report
az storage blob download \
  --account-name cdscostmgmtreports \
  --container-name exports \
  --name "$FILE" \
  --file report.csv
