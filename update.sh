#!/bin/bash

version=$(curl -fsSL "https://api.github.com/repos/morpheus65535/bazarr/commits/python3" | jq -r .sha)
[[ -z ${version} ]] && exit
find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG BAZARR_VERSION=.*$/ARG BAZARR_VERSION=${version}/g" {} \;
sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version}}/g" .drone.yml
echo "##[set-output name=version;]${version}"
