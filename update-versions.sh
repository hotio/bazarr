#!/bin/bash
set -euo pipefail

while read -r line; do
    key="${line%%=*}"
    key="${key%__command}"
    command="${line#*=}"
    value=$(eval "${command}")
    json=$(cat meta.json)
    jq --sort-keys --arg key "$key" --arg value "$value" '.[$key] = $value' <<< "${json}" > meta.json
    echo "Result: [${key}] [${command}] [${value}]"
done < <(jq -r 'to_entries[] | [(.key),.value] | join("=")' < meta.json | grep '__command')
