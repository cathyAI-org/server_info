# Current Infrastructure

**Last verified:** 2026-03-04 (Europe/Stockholm)

## Overview

The cathyAI homelab is built on a 3-node Proxmox VE cluster with centralized AI services, Matrix bots, and unified prompt composition.

## Proxmox Cluster

### Architecture

- **Cluster Name:** cathyAI-cluster
- **Nodes:** 3
- **Primary Use Cases:**
  - AI/LLM inference with unified orchestration
  - Matrix homeserver with AI-powered bots
  - Centralized memory and prompt composition
  - Secure storage (TrueNAS)
  - Self-hosted productivity tools
  - Media services (planned — Media LXC on ASUS NUC)

### Node Roles

| Node             | Primary Role                | Secondary Role                                                                       |
|------------------|-----------------------------|--------------------------------------------------------------------------------------|
| Main Host        | General services            | TrueNAS VM, infrastructure                                                           |
| ESIMOER NUC      | General compute             | Chainlit WebUI                                                                       |
| ASUS NUC 15 Pro+ | NPU-SVC, NPU-accelerated AI | Ollama API, AI Orchestrator, Prompt Composer. Planned: Media LXC (shared future GPU) |

### IP Address Map

| IP           | Host/VM/LXC       | Node            | Purpose                                      |
|--------------|-------------------|-----------------|----------------------------------------------|
| 192.168.1.17 | TrueNAS VM        | Main Host       | Bulk storage, backups                        |
| 192.168.1.51 | Proxmox Main Host | —               | Cluster node, infrastructure                 |
| 192.168.1.52 | Home Assistant VM | Proxmox Cluster | Smart home (migrated from RPi4)              |
| 192.168.1.55 | ASUS NUC 15 Pro+  | —               | AI service node, NPU-SVC                     |
| 192.168.1.57 | cathy-AI API LXC  | ASUS NUC        | Ollama API, AI Orchestrator, Prompt Composer |
| 192.168.1.59 | catcord VM        | Main Host       | Matrix, bots, APIs                           |
| 192.168.1.60 | ESIMOER NUC       | —               | Proxmox node, Chainlit WebUI                 |
| 192.168.1.61 | GitRack LXC       | Main Host       | Forgejo, RackPeek                            |
| 192.168.1.63 | WireGuard VM      | Main Host       | VPN                                          |
| 192.168.1.64 | Tailscale LXC     | Main Host       | VPN                                          |
| 192.168.1.65 | Bitwarden LXC     | Main Host       | Password manager                             |

### Main Host VMs and LXCs

#### catcord VM (192.168.1.59)

**Public Hostname:** catcord.duckdns.org  
**Port Forwards:** WAN 80/443 → 192.168.1.59:80/443

Matrix homeserver and related services:
- **Matrix Conduit** (127.0.0.1:6167): Homeserver (localhost only, proxied by Caddy)
- **Caddy** (80/443): Reverse proxy with TLS
- **Character API** (8090): Character card management
- **Identity API** (8092): User identity mapping
- **Memory Service** (docker-internal `memory:8090` on `catcord_internal` network): catcord-memory, no host-exposed port
- **Online Service** (docker-internal `online:8088` on `catcord_internal` network): RSS fetch for news bot, no host-exposed port
- **Cleaner Event Bot** (`cleaner_event`): Event-driven media retention (30d non-images, 90d images) + disk pressure cleanup, always running
- **Cleaner Bot** (`cleaner_bot`): Scheduled/manual cleanup runs (`restart: no`)
- **News Bot (Delilah)** (`news_bot`): RSS aggregation, manually triggered (`restart: no`)

**Storage:**
- Root: 50GB (OS, apps, config)
- /srv/media: 150GB ext4 (Matrix media only)

**Matrix Config (Locked):**
- Federation: OFF
- Registration: OFF (invite-only)
- Rooms: Unencrypted
- Upload limit: 100MB

#### GitRack LXC (192.168.1.61)

Self-hosted Git and documentation infrastructure:
- **Proxmox CT ID:** 204
- **OS:** Debian 12
- **Resources:** 2 cores, 2048 MB RAM, 16 GB disk (nvme1tb)
- **Services:**
  - **Forgejo** (3000): Self-hosted Git server (codeberg.org/forgejo/forgejo:14)
    - Web UI: http://192.168.1.61:3000
    - SSH: Port 2222
    - Hosts all personal tools and RackPeek config
  - **RackPeek** (8080): Living homelab documentation (aptacode/rackpeek:latest)
    - Web UI: http://192.168.1.61:8080
    - Config: ~/homelab-services/rackpeek-config/config.yaml (bind-mounted)
    - Documents entire homelab: Proxmox cluster, NUCs, Home Assistant VM, Eufy cameras, Synology NAS, PCs
- **Deployment:** Single LXC with Docker Compose (version 3.9)
- **Workflow:** Edit in RackPeek UI → git commit & push to Forgejo repo "homelab-rackpeek"
- **Docker Compose:** ~/homelab-services/docker-compose.yml (TZ=Europe/Stockholm)

### ASUS NUC LXCs

#### cathy-AI API LXC (192.168.1.57)

All AI infrastructure services from the `cathyAI-infra` repo, deployed via single docker-compose:
- **ollama-api** (8100): LLM proxy (container: `cathyai-api`)
- **prompt-composer** (8110): Unified prompt assembly (container: `cathyai-prompt-composer`)
- **ai-orchestrator** (8120): Multi-model routing, depends on prompt-composer + ollama-api (container: `cathyai-ai-orchestrator`)
- **Ollama** (11434): LLM backend (host service on ASUS NUC)
- **Health:** GET /health on each service

> **Note:** The standalone `cathyAI-API` repo in the GitHub org is superseded by `cathyAI-infra/ollama-api`. The running container `cathyai-api` is built from `cathyAI-infra`.

## Storage Layout

### Main Host Storage

| Device   | Type          | Capacity      | Purpose              |
|----------|---------------|---------------|----------------------|
| Boot SSD | NVMe          | 512GB         | Proxmox OS, system   |
| Fast SSD | NVMe          | 1TB           | VM storage, cache    |
| HDD Pool | HBA-connected | Multiple HDDs | TrueNAS bulk storage |

### TrueNAS Pools

- **Primary Pool:** Bulk storage for media, backups, archives
- **Fast Pool/Cache:** SSD-based for frequently accessed data
- **Boot:** Dedicated boot device for TrueNAS VM

### NUC Storage

- **ESIMOER NUC (192.168.1.60):** 1TB NVMe SSD (VMs, containers, Chainlit WebUI)
- **ASUS NUC 15 Pro+ (192.168.1.55):** 1TB NVMe SSD (NPU workloads, AI models, Ollama API, AI Orchestrator, Prompt Composer)

## Network Configuration

**Internal Network:** 192.168.1.0/24  
See [IP Address Map](#ip-address-map) for the full host/VM/LXC address table.

- **VPN:** Tailscale + WireGuard for secure remote access
- **Service Discovery:** Direct IP + port (reverse proxy planned)

## Service Architecture

### AI Pipeline

```
User Request
    ↓
Chainlit WebUI (192.168.1.60:8000)
    ↓
prompt-composer (192.168.1.57:8110) → Character API (192.168.1.59:8090)
    ↓                               → Identity API (192.168.1.59:8092)
    ↓                               → catcord-memory (docker-internal, no host port)
    ↓
ai-orchestrator (192.168.1.57:8120) → ollama-api (192.168.1.57:8100) → Ollama (192.168.1.57:11434)
    ↓                               → NPU-SVC (192.168.1.55:8010)
    ↓
Response
```

### Matrix Bot Architecture

```
Matrix Event
    ↓
Bot (Irina/Delilah)
    ↓
prompt-composer (192.168.1.57:8110) → Persona binding
    ↓
ai-orchestrator (192.168.1.57:8120) → LLM inference
    ↓
Matrix Response
```

## Deployment Strategy

- **VMs:** TrueNAS, catcord (central services)
- **LXC Containers:** Lightweight infrastructure services
- **Docker:** All AI services, bots, APIs via docker-compose
- **Environment:** All secrets in `.env` files (never committed)

## High Availability

- 3-node cluster enables VM migration and redundancy
- Critical services on catcord VM can migrate between nodes
- Ollama and NPU-SVC distributed across nodes for load balancing

## Network Topology

### Physical Layout

```
Internet (500/500 Mbps)
    ↓
Ubiquiti Dream Router 7 (Wi-Fi 7, 2.5GbE WAN)
    ├── DIY PC Proxmox Node (Main Host) [Cat 6a]
    ├── Main Work/Gaming PC [Cat 8]
    └── SODOLA 8-Port 2.5GbE Switch [10G SFP+]
        ├── Synology NAS [Cat 6a]
        ├── Philips 50" PUS8500 TV [Cat 6]
        ├── Zyxel 5-Port Gigabit Switch [Cat 6a]
        │   ├── ASUS NUC 15 Pro+ [Cat 6a]
        │   └── ESIMOER Intel NUC [Cat 6a]
        └── TP-Link TL-SG105 5-Port Gigabit Switch [Cat 6]
            ├── Console Gaming PC (Bazzite) [Cat 6]
            └── Emulation PC (Batocera) [Cat 6]
```

### Network Segments

| Segment        | VLAN   | Purpose                         | Devices                           |
|----------------|--------|---------------------------------|-----------------------------------|
| **Management** | Native | Proxmox cluster, infrastructure | DIY PC, ASUS NUC, ESIMOER NUC     |
| **Services**   | Native | VMs, LXCs, services             | catcord VM, GitRack LXC, TrueNAS  |
| **IoT**        | Native | Smart home devices              | Eufy HomeBase 3, Philips TV       |
| **Client**     | Native | Workstations and gaming         | Main PC, Console PC, Emulation PC |
| **Storage**    | Native | NAS and backup                  | Synology NAS, TrueNAS             |

### Switch Roles

- **SODOLA 2.5GbE:** Central backbone connected to router via 10G SFP+, connects Synology NAS, Philips TV, and both downstream switches
- **Zyxel 5-Port:** Connects ASUS NUC and ESIMOER NUC to SODOLA switch
- **TP-Link TL-SG105:** Connects Console Gaming PC and Emulation PC to SODOLA switch

### Bandwidth Allocation

- **10G SFP+:** Router to SODOLA switch (backbone)
- **2.5GbE:** Synology NAS, downstream switches
- **1GbE:** IoT devices (TV), NUCs, gaming PCs
- **Direct to Router:** DIY Proxmox Node, Main Work/Gaming PC (Cat 8)

### ISP Connection

- **Service:** 500/500 Mbps fiber
- **WAN Port:** Ubiquiti Dream Router 7 (2.5GbE)
- **Public IP:** Not CGNAT
- **Port Forwards to catcord VM:**
  - TCP 443 → 192.168.1.59:443
  - TCP 80 → 192.168.1.59:80

### Wireless Network

- **Wi-Fi 7 (6 GHz):** Ubiquiti Dream Router 7
- **Coverage:** 160 m²
- **Clients:** Mobile devices, laptops, Eufy cameras (via HomeBase 3)

---

*See [Hardware](02-hardware.md) for detailed specifications.*
