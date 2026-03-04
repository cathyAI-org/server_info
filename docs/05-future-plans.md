# Future Plans

## Priority Roadmap

### High Priority

#### 1. 3-Node Proxmox Cluster Finalization
**Status:** In progress  
**Goal:** Complete HA cluster setup

- Verify quorum and fencing
- Test VM migration between nodes
- Configure shared storage (if needed)
- Document failover procedures

#### 2. !remove Command in Cleaner Bot
**Status:** Planned  
**Goal:** Manual message deletion via reply

- Detect `!remove` as reply to target message
- Delete target + command messages
- Respect permissions and rate limits
- Log deletions for audit

#### 3. Embeddings + Distillation in catcord-memory
**Status:** Planned  
**Goal:** Full RAG with semantic search

- Implement embedding generation pipeline
- Add semantic search with relevance scoring
- Memory distillation (summarization)
- Time-based decay for old memories

#### 4. Jellyfin Deployment
**Status:** Planned  
**Goal:** Self-hosted media streaming

- Deploy on Main Host or NUC
- Integrate with TrueNAS storage
- Configure hardware transcoding
- Set up user accounts and libraries

#### 5. Bitwarden Deployment
**Status:** Planned  
**Goal:** Self-hosted password manager

- Deploy Vaultwarden (lightweight)
- Secure with HTTPS (Let's Encrypt)
- Backup vault to TrueNAS
- Configure SMTP notifications

---

### Medium Priority

#### 6. Home Assistant Migration to Proxmox
**Status:** Planned  
**Goal:** Migrate from standalone RPi4 to HAOS VM on Proxmox cluster

- Run helper script: `bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/haos-vm.sh)"`
- New HAOS VM: 2–4 vCPU, 6–8 GB RAM, 32+ GB disk on shared SSD storage
- USB passthrough for Zigbee/Z-Wave dongles using Vendor/Device ID (stable even after live migration)
- Migration: full backup from Pi → restore in new VM (zero data loss)
- Benefits: live migration between 3 nodes with zero downtime, Proxmox snapshots + PBS backups, no SD-card wear, much snappier
- Avoid Pimox completely — pure x86 VM on existing cluster
- RPi4 becomes cold spare or repurposed after migration

#### 7. Diary Generation Pipeline
**Status:** Planned  
**Goal:** Daily conversation summaries

- Daily summary of conversations
- Emotional tone analysis
- Key events and topics extraction
- Stored as structured data for RAG

#### 8. Systemd Timers for All Bots
**Status:** Planned  
**Goal:** Reliable bot lifecycle management

- Replace docker-compose with systemd services
- Add restart policies and health checks
- Enable automatic startup on boot
- Centralized logging with journald

#### 9. Reverse Proxy with SSL
**Status:** Planned  
**Goal:** Secure external access

- Deploy Nginx Proxy Manager or Traefik
- Configure Let's Encrypt SSL
- Set up domain names for services
- Implement authentication

---

### Low Priority / Future

#### 10. Nextcloud
**Status:** Future  
**Goal:** Self-hosted file sync

- Deploy as VM on Main Host
- Integrate with TrueNAS storage
- Configure CalDAV, CardDAV
- Set up mobile sync

#### 11. Prometheus + Grafana
**Status:** Future  
**Goal:** Comprehensive monitoring

- Deploy Prometheus for metrics
- Deploy Grafana for visualization
- Create dashboards (CPU, RAM, disk, network)
- Set up alerts for thresholds

#### 12. Backup Automation
**Status:** Future  
**Goal:** Automated, tested backups

- Proxmox Backup Server or Restic
- Scheduled backups to TrueNAS
- Off-site backup to cloud (encrypted)
- Regular restore testing

---

## Timeline Estimate

| Quarter | Focus |
|---------|-------|
| **Q1 2026** | Cluster finalization, !remove command |
| **Q2 2026** | Embeddings + distillation, Jellyfin, Bitwarden |
| **Q3 2026** | Home Assistant migration, diary generation, systemd timers |
| **Q4 2026** | Reverse proxy, Nextcloud, monitoring |
