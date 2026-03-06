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

#### 6. Update Firmware on Sonoff Zigbee 3.0 USB Dongle Plus (ZBDongle-P)
**Status:** Planned  
**Goal:** Maintain Zigbee coordinator firmware for optimal Home Assistant performance

**Why Priority 1:**

Keeping the dongle's firmware updated is critical for maintaining compatibility with Zigbee2MQTT in Home Assistant, resolving bugs, improving device pairing reliability, enhancing network stability, and ensuring security against known vulnerabilities in older versions.

**Update Procedure:**

1. **Check for the latest firmware:** Visit https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator/Z-Stack_3.x.0/bin and download the most recent CC2652P coordinator firmware ZIP file (e.g., CC2652P_coordinator_YYYYMMDD.zip). Unzip it to extract the .hex file.

2. **Prepare the dongle:** Temporarily unplug the dongle from the Home Assistant host and connect it to a computer with USB access. Ensure no other software (like Zigbee2MQTT or ZHA) is accessing it.

3. **Install flashing tool:** Download and install Texas Instruments SmartRF Flash Programmer 2 from https://www.ti.com/tool/FLASH-PROGRAMMER (available for Windows, macOS, or Linux). Alternatively, use the web-based TI UniFlash tool at https://dev.ti.com/uniflash/.

4. **Flash the firmware:** Open the flashing tool, select the CC2652P as the target device, load the extracted .hex file, enable "Erase" and "Program" options, and initiate the flash process. Wait for completion and verify success.

5. **Reconnect and test:** Replug the dongle into the Home Assistant host. In Zigbee2MQTT, restart the add-on and check the logs for the updated firmware version (e.g., "Coordinator firmware version: 'YYYYMMDD'"). If issues persist, adjust the baudrate to 460800 in the configuration.

---

### Medium Priority

#### 7. Home Assistant Migration to Proxmox
**Status:** Planned  
**Goal:** Migrate from standalone RPi4 to HAOS VM on Proxmox cluster

- Run helper script: `bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/haos-vm.sh)"`
- New HAOS VM: 2–4 vCPU, 6–8 GB RAM, 32+ GB disk on shared SSD storage
- USB passthrough for Zigbee/Z-Wave dongles using Vendor/Device ID (stable even after live migration)
- Migration: full backup from Pi → restore in new VM (zero data loss)
- Benefits: live migration between 3 nodes with zero downtime, Proxmox snapshots + PBS backups, no SD-card wear, much snappier
- Avoid Pimox completely — pure x86 VM on existing cluster
- RPi4 becomes cold spare or repurposed after migration

#### 8. Diary Generation Pipeline
**Status:** Planned  
**Goal:** Daily conversation summaries

- Daily summary of conversations
- Emotional tone analysis
- Key events and topics extraction
- Stored as structured data for RAG

#### 9. Systemd Timers for All Bots
**Status:** Planned  
**Goal:** Reliable bot lifecycle management

- Replace docker-compose with systemd services
- Add restart policies and health checks
- Enable automatic startup on boot
- Centralized logging with journald

#### 10. Reverse Proxy with SSL
**Status:** Planned  
**Goal:** Secure external access

- Deploy Nginx Proxy Manager or Traefik
- Configure Let's Encrypt SSL
- Set up domain names for services
- Implement authentication

#### 11. Technitium DNS Server Deployment
**Status:** Planned  
**Goal:** Self-hosted recursive DNS with ad blocking and privacy features

- Deploy in a lightweight Ubuntu VM on Proxmox (e.g., on Main Host or NUC) with 1-2 vCPU, 1-4 GB RAM, and SSD for caching
- Configure recursive mode with DNSSEC and DoH/DoT forwarders (e.g., Quad9 or Cloudflare) for encrypted queries
- Import ad/tracker blocklists for network-wide blocking, with auto-updates
- Integrate with VPNs (Tailscale/WireGuard) for secure remote resolutions
- Set up monitoring dashboard for query logs and analytics
- Point Ubiquiti router DNS to the Technitium IP for homelab-wide use
- Benefits: Enhanced privacy, ad-free browsing, better DNS troubleshooting without replacing existing setup

---

### Low Priority / Future

#### 12. Nextcloud
**Status:** Future  
**Goal:** Self-hosted file sync

- Deploy as VM on Main Host
- Integrate with TrueNAS storage
- Configure CalDAV, CardDAV
- Set up mobile sync

#### 13. Prometheus + Grafana
**Status:** Future  
**Goal:** Comprehensive monitoring

- Deploy Prometheus for metrics
- Deploy Grafana for visualization
- Create dashboards (CPU, RAM, disk, network)
- Set up alerts for thresholds

#### 14. Backup Automation
**Status:** Future  
**Goal:** Automated, tested backups

- Proxmox Backup Server or Restic
- Scheduled backups to TrueNAS
- Off-site backup to cloud (encrypted)
- Regular restore testing

---

### Future / Research

#### 15. HBA Passthrough Storage Mode
**Status:** Design proposal  
**Goal:** PCI passthrough of LSI SAS2308 HBA to TrueNAS VM while preserving power-saving disk behavior

**Current State:**
- Main Host has LSI 9207-8i HBA (SAS2308) with 4 HDDs
- TrueNAS VM runs on Main Host but HBA not yet passed through
- Target: 15-minute idle spindown policy (disks can draw 30W+ when spinning)

**Design Approach:**

Support two storage modes:

1. **host-managed** (current):
   - Disks controlled by Proxmox host
   - Spindown via hdparm
   - Direct host monitoring

2. **passthrough-hba** (proposed):
   - Entire PCIe SAS controller passed to TrueNAS VM
   - Host avoids disk access entirely
   - Monitoring relies on cached data or TrueNAS APIs

**Implementation Requirements:**

- Configure PCIe passthrough in Proxmox (IOMMU, VFIO)
- Pass entire HBA to TrueNAS VM (all 4 HDDs become VM-exclusive)
- Configure TrueNAS power management:
  - Set disk spindown to 15 minutes idle
  - Disable unnecessary SMART polling
  - Batch health checks to minimize wakeups
- Modify any host-side monitoring to:
  - Query TrueNAS API instead of direct disk access
  - Cache disk metadata (model, serial, capacity)
  - Schedule SMART checks infrequently (6-24 hour intervals)
  - Avoid filesystem queries that trigger spinups

**Power Optimization Goals:**

- Disks spin down after 15 minutes idle
- Disks remain spun down during normal operation
- Monitoring does not trigger unnecessary wakeups
- SMART health checks scheduled during maintenance windows
- Idle power draw minimized (target: <10W for spun-down disks)

**Monitoring Strategy:**

Separate checks into two categories:

- **Low-impact** (frequent, cached):
  - Disk metadata (model, serial, capacity)
  - Pool status from TrueNAS API
  - Non-disk system metrics

- **Disk-impacting** (infrequent, scheduled):
  - SMART attribute reads (every 6-24 hours)
  - Scrub operations (weekly/monthly)
  - Filesystem metadata queries

**Benefits:**

- Native disk management by TrueNAS (better ZFS integration)
- Cleaner separation: VM owns storage hardware
- Enables VM migration (with HBA) if needed
- Maintains low idle power consumption
- Preserves disk health monitoring

**Risks:**

- Host loses direct disk visibility
- Requires TrueNAS API for monitoring
- HBA becomes VM-exclusive (no host access)
- Migration complexity if HBA is passed through

**Documentation Needed:**

- Proxmox PCIe passthrough configuration guide
- TrueNAS power management settings
- Monitoring script modifications
- Comparison: host-managed vs passthrough modes
- Best practices for low-power NAS setups

---

## Timeline Estimate

| Quarter | Focus |
|---------|-------|
| **Q1 2026** | Cluster finalization, !remove command |
| **Q2 2026** | Embeddings + distillation, Jellyfin, Bitwarden |
| **Q3 2026** | Home Assistant migration, diary generation, systemd timers |
| **Q4 2026** | Reverse proxy, Nextcloud, monitoring |
