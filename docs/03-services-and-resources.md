# Services and Resources

## Service Inventory

### Core Infrastructure

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **TrueNAS** | Main Host | VM | 4 | 16GB | 512GB + HDDs | - | Running |
| **Tailscale** | Main Host | LXC | 1 | 512MB | 2GB | - | Running |
| **WireGuard** | Main Host | VM | 1 | 512MB | 2GB | - | Running |
| **Forgejo** | GitRack LXC (Main Host) | Container in LXC | 1 | 512MB | 8GB | 3000, 2222 | Running |
| **RackPeek** | GitRack LXC (Main Host) | Container in LXC | 1 | 512MB | 4GB | 8080 | Running |

### AI Infrastructure Services

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **prompt-composer** | catcord VM | Docker | 2 | 2GB | 5GB | 8110 | Running |
| **ollama-api** | catcord VM | Docker | 2 | 2GB | 5GB | 8100 | Running |
| **ai-orchestrator** | catcord VM | Docker | 2 | 4GB | 10GB | 8120 | Running |
| **Ollama** | cathy-AI API LXC (ASUS NUC) | LXC | 8 | 32GB | 100GB | 11434 | Running |
| **NPU-SVC** | ASUS NUC | Host Service | 4 | 8GB | 20GB | 8010 | Running |

### API Services

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **Character API** | catcord VM | Docker | 2 | 2GB | 10GB | 8090 | Running |
| **Identity API** | catcord VM | Docker | 1 | 1GB | 5GB | 8091 | Running |
| **catcord-memory** | catcord VM | Docker | 2 | 4GB | 20GB | 8095 | Running |

### Web Interfaces

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **Chainlit WebUI** | openwebui LXC (ESIMOER NUC) | LXC | 2 | 2GB | 5GB | 8000 | Running |
| **Element (Matrix)** | catcord VM | Docker | 1 | 1GB | 2GB | 8080 | Running |

### Matrix Ecosystem

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **Conduit** | catcord VM | Docker | 2 | 4GB | 20GB | 6167 | Running |
| **Cleaner Bot (Irina)** | catcord VM | Docker | 1 | 512MB | 2GB | - | Running |
| **News Bot (Delilah)** | catcord VM | Docker | 1 | 512MB | 2GB | - | Running |

### Planned Services

| Service | Node | Type | CPU | RAM | Disk | Status |
|---------|------|------|-----|-----|------|--------|
| **Home Assistant** | Proxmox Cluster | VM (HAOS) | 2-4 | 6-8GB | 32GB | Planned (migration from RPi4) |
| **Jellyfin** | Main Host | VM | 4 | 8GB | 50GB | Planned |
| **Bitwarden** | Main Host | Container | 2 | 2GB | 10GB | Planned |

## Service Architecture

### catcord VM (192.168.1.59)

Central hub hosting all AI and bot services:

```
Character API (8090)     ← Character card management
Identity API (8091)      ← User identity mapping
catcord-memory (8095)    ← Conversation memory + RAG
prompt-composer (8110)   ← Unified prompt assembly
ollama-api (8100)        ← Ollama proxy/routing
ai-orchestrator (8120)   ← Multi-model orchestration
Chainlit WebUI (8000)    ← User interface
Matrix Conduit (6167)    ← Homeserver
Cleaner Bot (Irina)      ← Message cleanup
News Bot (Delilah)       ← RSS aggregation
```

### GitRack LXC (192.168.1.61)

Self-hosted Git and documentation:

```
Forgejo (3000, SSH 2222) ← Private Git server
RackPeek (8080)          ← Living homelab documentation
```

## Deployment Patterns

### docker-compose Standard

```yaml
services:
  service_name:
    image: service:latest
    env_file: .env
    volumes:
      - ./data:/app/data
    ports:
      - "8080:8080"
```

### Environment Variables

- All secrets in `.env` files
- Never committed to git
- Template in [Secrets Management](04-secrets-management.md)

## Resource Allocation Summary

### Main Host (Ryzen 5 5600G, 32GB RAM)
- **Allocated:** ~8 cores, ~24GB RAM
- **Primary:** TrueNAS VM, Tailscale LXC, WireGuard VM

### ESIMOER NUC (i5-1235U, 64GB RAM)
- **Allocated:** ~8 cores, ~32GB RAM
- **Primary:** openwebui LXC (Chainlit WebUI)

### ASUS NUC 15 Pro+ (Core Ultra 5 225H, 32GB RAM)
- **Allocated:** ~12 cores, ~40GB RAM
- **Primary:** cathy-AI API LXC (Ollama), NPU-SVC (host service)

### catcord VM (192.168.1.59)
- **Allocated:** ~16 cores, ~24GB RAM
- **Services:** All APIs, bots, WebUI, Matrix

### GitRack LXC (192.168.1.61)
- **Allocated:** 2 cores, 2GB RAM, 16GB disk
- **Services:** Forgejo, RackPeek
