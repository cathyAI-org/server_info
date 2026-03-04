# Services and Resources

## Service Inventory

### Core Infrastructure

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **TrueNAS** | Main Host | VM | 4 | 16GB | 512GB + HDDs | - | Running |
| **Tailscale** | All nodes | Native | - | - | - | - | Running |
| **WireGuard** | Main Host | Container | 1 | 512MB | 2GB | - | Running |

### AI Infrastructure Services

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **prompt-composer** | catcord VM | Docker | 2 | 2GB | 5GB | 8110 | Running |
| **ollama-api** | catcord VM | Docker | 2 | 2GB | 5GB | 8100 | Running |
| **ai-orchestrator** | catcord VM | Docker | 2 | 4GB | 10GB | 8120 | Running |
| **Ollama** | ESIMOER NUC | Docker | 8 | 32GB | 100GB | 11434 | Running |
| **NPU-SVC** | ASUS NUC / Main | Docker | 4 | 8GB | 20GB | 8010 | Running |

### API Services

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **Character API** | catcord VM | Docker | 2 | 2GB | 10GB | 8090 | Running |
| **Identity API** | catcord VM | Docker | 1 | 1GB | 5GB | 8091 | Running |
| **catcord-memory** | catcord VM | Docker | 2 | 4GB | 20GB | 8095 | Running |

### Web Interfaces

| Service | Node | Type | CPU | RAM | Disk | Port | Status |
|---------|------|------|-----|-----|------|------|--------|
| **Chainlit WebUI** | catcord VM | Docker | 2 | 2GB | 5GB | 8000 | Running |
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
- **Primary:** TrueNAS, NPU-SVC, WireGuard

### ESIMOER NUC (i5-1235U, 64GB RAM)
- **Allocated:** ~8 cores, ~32GB RAM
- **Primary:** Ollama

### ASUS NUC 15 Pro+ (Core Ultra 5 225H, 32GB RAM)
- **Allocated:** ~6 cores, ~12GB RAM
- **Primary:** NPU-SVC, ai-orchestrator

### catcord VM (192.168.1.59)
- **Allocated:** ~16 cores, ~24GB RAM
- **Services:** All APIs, bots, WebUI, Matrix
