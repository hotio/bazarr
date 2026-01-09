#!/bin/bash
set -exuo pipefail

version=$(curl -fsSL "https://api.github.com/repos/morpheus65535/bazarr/releases" | jq -re .[0].tag_name)
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    '.version = $version' <<< "${json}" | tee VERSION.json
