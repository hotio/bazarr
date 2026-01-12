#!/bin/bash
set -exuo pipefail

version=$(curl -fsSL "https://api.github.com/repos/morpheus65535/bazarr/releases/latest" | jq -re .tag_name)
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    '.version = $version' <<< "${json}" | tee meta.json
