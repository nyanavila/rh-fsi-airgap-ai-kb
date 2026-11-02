#!/bin/bash
# Export Red Hat Lightspeed IoP Container Images for Air-Gapped Satellite 6.19
set -euo pipefail

EXPORT_DIR="/tmp/lightspeed_tarball"
mkdir -p "${EXPORT_DIR}"

IMAGES=(
  "satellite/iop-ingress-rhel9:6.19"
  "satellite/iop-advisor-frontend-rhel9:6.19"
  "satellite/iop-host-inventory-rhel9:6.19"
  "satellite/iop-vmaas-rhel9:6.19"
  "satellite/iop-remediations-rhel9:6.19"
  "satellite/iop-vulnerability-frontend-rhel9:6.19"
  "satellite/iop-host-inventory-frontend-rhel9:6.19"
  "satellite/iop-advisor-backend-rhel9:6.19"
  "satellite/iop-puptoo-rhel9:6.19"
  "satellite/iop-yuptoo-rhel9:6.19"
  "satellite/iop-insights-engine-rhel9:6.19"
  "satellite/iop-vulnerability-engine-rhel9:6.19"
  "satellite/iop-gateway-rhel9:6.19"
  "amq-streams/kafka-39-rhel9:2.9.1-1"
)

echo "=== Pulling and Saving Red Hat Lightspeed IoP Images ==="
for img in "${IMAGES[@]}"; do
  name=$(basename "${img}" | cut -d: -f1)
  full_url="registry.redhat.io/${img}"
  
  echo "Processing ${name}..."
  skopeo copy "docker://${full_url}" "containers-storage:${full_url}"
  skopeo copy "containers-storage:${full_url}" "oci-archive:${EXPORT_DIR}/${name}.tar"
done

echo "Export complete. Transfer ${EXPORT_DIR} to your disconnected Satellite server."
