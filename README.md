# Red Hat FSI Air-Gapped Knowledge & AI Assistant Infrastructure

Automated repository for running RHOKP, In-Satellite Red Hat Lightspeed (IoP), and the Satellite MCP Gateway in disconnected, zero-trust financial environments.

## Deployment Sequence

1. **Deploy RHOKP Documentation Container**:
   ```bash
   ansible-playbook -i inventory/hosts.ini playbooks/01_deploy_rhokp_container.yml
