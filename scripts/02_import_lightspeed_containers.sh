#!/bin/bash
# Import Red Hat Lightspeed IoP Container Images into local Podman storage
set -euo pipefail

SOURCE_DIR="${1:-/tmp/lightspeed_tarball}"

if [ ! -d "${SOURCE_DIR}" ]; then
  echo "Error: Directory ${SOURCE_DIR} not found." >&2
  exit 1
fi

echo "=== Importing OCI Archives into Local Container Storage ==="
for tarfile in "${SOURCE_DIR}"/*.tar; do
  [ -f "${tarfile}" ] || continue
  name=$(basename "${tarfile}" .tar)
  echo "Importing ${name}..."
  skopeo copy "oci-archive:${tarfile}" "containers-storage:registry.redhat.io/satellite/${name}:6.19"
done

echo "Import complete. Images available in Podman storage."
