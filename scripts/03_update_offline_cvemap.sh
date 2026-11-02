#!/bin/bash
# Sync CVE map data locally for Satellite's vulnerability engine
set -euo pipefail

DEST_PATH="/var/lib/foreman/cvemap.xml"
SOURCE_FILE="${1:-./files/cvemap.xml}"

if [ ! -f "${SOURCE_FILE}" ]; then
  echo "Error: Source CVE map file not found at ${SOURCE_FILE}" >&2
  exit 1
fi

install -m 0644 -o foreman -g foreman "${SOURCE_FILE}" "${DEST_PATH}"
echo "CVE map file successfully updated at ${DEST_PATH}."
