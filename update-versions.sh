#!/bin/bash

version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/morpheus65535/bazarr/releases" | jq -r .[0].tag_name | sed s/v//g)
[[ -z ${version} ]] && exit 0
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version}" \
    '.version = $version' <<< "${json}" > VERSION.json
