# Current Infrastructure

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
  - Media streaming and secure storage
  - Self-hosted productivity tools

### Node Roles

| Node | Primary Role | Secondary Role |
|------|--------------|----------------|
| Main Host | General services | TrueNAS, infrastructure |
| ESIMOER NUC | General compute | Ollama services frontend |
| ASUS NUC 15 Pro+ | NPU-SVC, NPU-accelerated AI | AI orchestration |

### catcord VM (192.168.1.59)

Central hub for all AI and bot services:
- **Character API** (8090): Character card management with public/private views
- **Identity API** (8091): User identity mapping
- **catcord-memory** (8095): Conversation memory with RAG
- **prompt-composer** (8110): Unified prompt assembly
- **ollama-api** (8100): Ollama proxy and routing
- **ai-orchestrator** (8120): Multi-model orchestration
- **Chainlit WebUI** (8000): User interface with ETag caching
- **Matrix Conduit** (6167): Homeserver
- **Cleaner Bot (Irina)**: Message cleanup
- **News Bot (Delilah)**: RSS feed aggregation

### GitRack LXC (192.168.1.61)

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
    - Documents entire homelab: Proxmox cluster, NUCs, RPi4 (Home Assistant - planned migration to Proxmox), Eufy cameras, Synology NAS, PCs
- **Deployment:** Single LXC with Docker Compose (version 3.9)
- **Workflow:** Edit in RackPeek UI → git commit & push to Forgejo repo "homelab-rackpeek"
- **Docker Compose:** ~/homelab-services/docker-compose.yml (TZ=Europe/Stockholm)

## Storage Layout

### Main Host Storage

| Device | Type | Capacity | Purpose |
|--------|------|----------|---------|
| Boot SSD | NVMe/SATA | 512GB | Proxmox OS, system |
| Fast SSD | SATA/NVMe | 1TB | VM storage, cache |
| HDD Pool | HBA-connected | Multiple HDDs | TrueNAS bulk storage |

### TrueNAS Pools

- **Primary Pool:** Bulk storage for media, backups, archives
- **Fast Pool/Cache:** SSD-based for frequently accessed data
- **Boot:** Dedicated boot device for TrueNAS VM

### NUC Storage

- **ESIMOER NUC:** 1TB NVMe SSD (VMs, containers, Ollama models)
- **ASUS NUC 15 Pro+:** 1TB NVMe SSD (NPU workloads, AI models)

## Network Configuration

- **Internal Network:** 192.168.1.0/24
- **catcord VM:** 192.168.1.59 (central services hub)
- **VPN:** Tailscale + WireGuard for secure remote access
- **Service Discovery:** Direct IP + port (reverse proxy planned)

## Service Architecture

### AI Pipeline

```
User Request
    ↓
Chainlit WebUI (8000)
    ↓
prompt-composer (8110) → Character API (8090)
    ↓                    → Identity API (8091)
    ↓                    → catcord-memory (8095)
    ↓
ai-orchestrator (8120) → ollama-api (8100) → Ollama (ESIMOER)
    ↓                    → NPU-SVC (8010) → NPU (ASUS/Main)
    ↓
Response
```

### Matrix Bot Architecture

```
Matrix Event
    ↓
Bot (Irina/Delilah)
    ↓
prompt-composer (8110) → Persona binding
    ↓
ai-orchestrator (8120) → LLM inference
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
        ├── Raspberry Pi 4 (Home Assistant) [Cat 6]
        ├── Philips 50" PUS8500 TV [Cat 6]
        ├── Zyxel 5-Port Gigabit Switch [Cat 6a]
        │   ├── ASUS NUC 15 Pro+ [Cat 6a]
        │   └── ESIMOER Intel NUC [Cat 6a]
        └── TP-Link TL-SG105 5-Port Gigabit Switch [Cat 6]
            ├── Console Gaming PC (Bazzite) [Cat 6]
            └── Emulation PC (Batocera) [Cat 6]
```

### Network Segments

| Segment | VLAN | Purpose | Devices |
|---------|------|---------|----------|
| **Management** | Native | Proxmox cluster, infrastructure | DIY PC, ASUS NUC, ESIMOER NUC |
| **Services** | Native | VMs, LXCs, services | catcord VM, GitRack LXC, TrueNAS |
| **IoT** | Native | Smart home devices | RPi4, Eufy HomeBase 3, Philips TV |
| **Client** | Native | Workstations and gaming | Main PC, Console PC, Emulation PC |
| **Storage** | Native | NAS and backup | Synology NAS, TrueNAS |

### Switch Roles

- **SODOLA 2.5GbE:** Central backbone connected to router via 10G SFP+, connects Synology NAS, RPi4, Philips TV, and both downstream switches
- **Zyxel 5-Port:** Connects ASUS NUC and ESIMOER NUC to SODOLA switch
- **TP-Link TL-SG105:** Connects Console Gaming PC and Emulation PC to SODOLA switch

### Bandwidth Allocation

- **10G SFP+:** Router to SODOLA switch (backbone)
- **2.5GbE:** Synology NAS, downstream switches
- **1GbE:** IoT devices (RPi4, TV), NUCs, gaming PCs
- **Direct to Router:** DIY Proxmox Node, Main Work/Gaming PC (Cat 8)

### ISP Connection

- **Service:** 500/500 Mbps fiber
- **WAN Port:** Ubiquiti Dream Router 7 (2.5GbE)

### Wireless Network

- **Wi-Fi 7 (6 GHz):** Ubiquiti Dream Router 7
- **Coverage:** 160 m²
- **Clients:** Mobile devices, laptops, Eufy cameras (via HomeBase 3)

---

*See [Hardware](02-hardware.md) for detailed specifications.*
