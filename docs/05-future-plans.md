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

#### 4. Media LXC on ASUS NUC
**Status:** Planned  
**Goal:** Self-hosted media services stack (movies, TV shows, music, audiobooks)

**Architecture:**
- Planned as a dedicated Media LXC on the ASUS NUC 15 Pro+
- Sits alongside the existing cathy-AI API LXC on the same node
- Both LXCs are intended to share access to a future external GPU for hardware-accelerated transcoding and AI inference
- No GPU-sharing implementation details are finalized yet; the ASUS NUC is the planned shared GPU-capable host

**Primary service:**
- Jellyfin as the main playback and front-end service

**Future direction — Arr-style media automation stack:**
- Candidate supporting services such as Sonarr, Radarr, Lidarr, Prowlarr, Bazarr, Jellyseerr, qBittorrent, and VPN/Gluetun-style networking
- Inspired by [automated media stack workflows](https://youtu.be/twJDyoj0tDc?si=D_7CRrvCX8WeCNxU)
- Exact service selection and configuration TBD

**Storage design:**
- Bulk media files (movies, TV, music, audiobooks) stored on the TrueNAS VM in a planned 8 TB mirrored storage area
- TrueNAS is the primary media repository; the Media LXC is the service layer
- App configs, cache, and transcode working data kept locally on SSD storage within the LXC where appropriate
- NFS or SMB mount from TrueNAS to the Media LXC (protocol TBD)

**Optional future enhancement:**
- Audiobook companion app (e.g., Audiobookshelf) may be considered as a future addition


### Medium Priority

#### 5. Diary Generation Pipeline
**Status:** Planned  
**Goal:** Daily conversation summaries

- Daily summary of conversations
- Emotional tone analysis
- Key events and topics extraction
- Stored as structured data for RAG


#### 6. Reverse Proxy with SSL
**Status:** Planned  
**Goal:** Secure external access

- Deploy Nginx Proxy Manager or Traefik
- Configure Let's Encrypt SSL
- Set up domain names for services
- Implement authentication

#### 7. Technitium DNS Server Deployment
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

#### 8. Nextcloud
**Status:** Future  
**Goal:** Self-hosted file sync

- Deploy as VM on Main Host
- Integrate with TrueNAS storage
- Configure CalDAV, CardDAV
- Set up mobile sync

#### 9. Prometheus + Grafana
**Status:** Future  
**Goal:** Comprehensive monitoring

- Deploy Prometheus for metrics
- Deploy Grafana for visualization
- Create dashboards (CPU, RAM, disk, network)
- Set up alerts for thresholds

#### 10. Backup Automation
**Status:** Future  
**Goal:** Automated, tested backups

- Proxmox Backup Server or Restic
- Scheduled backups to TrueNAS
- Off-site backup to cloud (encrypted)
- Regular restore testing

---

### Future / Research

#### 11. ARM-Based Disc Ripping Machine
**Status:** Research / candidate  
**Goal:** Investigate an automated disc-ripping workflow for physical media ingest

- Inspired by [ARM-style automatic ripping machine concepts](https://youtu.be/wPWx6GISIhY?si=PsCgOUu43zWclOO8)
- Ingest DVDs, Blu-rays, and UHD discs automatically
- Write ripped output to a TrueNAS staging or media share for the Media LXC to pick up
- Complements the ASUS NUC Media LXC but is a separate system

**Candidate placement:**
- ESIMOER NUC (192.168.1.60)
- Or a different dedicated mini PC / Proxmox node
- No final hardware decision yet

**Requirements:**
- External USB Blu-ray / UHD optical drive support
- Software stack for automated ripping (e.g., ARM, MakeMKV, HandBrake — TBD)
- Network access to TrueNAS media share for output

**Notes:**
- This is separate from the ASUS NUC Media LXC / AI LXC plan
- Hardware, software, and placement are all under investigation
- Not approved or deployed

---

## Timeline Estimate

| Quarter     | Focus                                    |
|-------------|------------------------------------------|
| **Q1 2026** | Cluster finalization, !remove command    |
| **Q2 2026** | Embeddings + distillation, Media LXC     |
| **Q3 2026** | Diary generation, reverse proxy          |
| **Q4 2026** | Nextcloud, monitoring, backup automation |
