# Services and Resources

**Last verified:** 2026-03-04 (Europe/Stockholm)

## Service Inventory

### Core Infrastructure

| Service            | Host      | Type                     | CPU | RAM   | Disk  | Port       | Status  |
|--------------------|-----------|--------------------------|-----|-------|-------|------------|---------|
| **TrueNAS**        | Main Host | VM                       | 4   | 16GB  | 512GB | -          | Running |
| **Tailscale**      | Main Host | LXC                      | 1   | 512MB | 2GB   | -          | Running |
| **WireGuard**      | Main Host | VM                       | 1   | 512MB | 2GB   | -          | Running |
| **Forgejo**        | Main Host | Container in GitRack LXC | 1   | 512MB | 8GB   | 3000, 2222 | Running |
| **RackPeek**       | Main Host | Container in GitRack LXC | 1   | 512MB | 4GB   | 8080       | Running |
| **Bitwarden**      | Main Host | LXC                      | 1   | 2GB   | 16GB  | -          | Running |
| **Home Assistant** | Main Host | VM                       | 2   | 6GB   | 64GB  | -          | Running |

### AI Infrastructure Services

| Service             | Host                                      | Type         | CPU | RAM  | Disk  | Port  | Status  |
|---------------------|-------------------------------------------|--------------|-----|------|-------|-------|---------|
| **ollama-api**      | cathy-AI API LXC (ASUS NUC, 192.168.1.57) | Docker       | 2   | 2GB  | 5GB   | 8100  | Running |
| **prompt-composer** | cathy-AI API LXC (ASUS NUC, 192.168.1.57) | Docker       | 2   | 2GB  | 5GB   | 8110  | Running |
| **ai-orchestrator** | cathy-AI API LXC (ASUS NUC, 192.168.1.57) | Docker       | 2   | 2GB  | 5GB   | 8120  | Running |
| **Ollama**          | cathy-AI API LXC (ASUS NUC, 192.168.1.57) | Host Service | 8   | 32GB | 100GB | 11434 | Running |
| **NPU-SVC**         | ASUS NUC (192.168.1.55)                   | Host Service | 4   | 8GB  | 20GB  | 8010  | Running |

### API Services

| Service            | Host       | Type   | CPU | RAM   | Disk | Port | Status     |
|--------------------|------------|--------|-----|-------|------|------|------------|
| **Character API**  | catcord VM | Docker | 2   | 2GB   | 10GB | 8090 | Running    |
| **Identity API**   | catcord VM | Docker | 1   | 1GB   | 5GB  | 8092 | Running    |
| **catcord-memory** | catcord VM | Docker | 2   | 4GB   | 20GB | -    | Restarting |
| **catcord-online** | catcord VM | Docker | 1   | 512MB | 2GB  | -    | Running    |

### Web Interfaces

| Service              | Host                        | Type   | CPU | RAM | Disk | Port | Status       |
|----------------------|-----------------------------|--------|-----|-----|------|------|--------------|
| **Chainlit WebUI**   | openwebui LXC (ESIMOER NUC) | LXC    | 2   | 2GB | 5GB  | 8000 | Host offline |
| **Element (Matrix)** | catcord VM                  | Docker | 1   | 1GB | 2GB  | 8080 | Running      |

### Matrix Ecosystem

| Service               | Host       | Type   | Port    | Status                 |
|-----------------------|------------|--------|---------|------------------------|
| **Conduit**           | catcord VM | Docker | 6167    | Running                |
| **Caddy**             | catcord VM | Docker | 80, 443 | Running                |
| **Cleaner Event Bot** | catcord VM | Docker | -       | Running                |
| **Cleaner Bot**       | catcord VM | Docker | -       | Manual (`restart: no`) |
| **News Bot**          | catcord VM | Docker | -       | Manual (`restart: no`) |


### Planned Services

| Service                  | Host                              | Type            | Status   | Notes                                                                                                                                                                                  |
|--------------------------|-----------------------------------|-----------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Media LXC**            | ASUS NUC 15 Pro+                  | LXC             | Planned  | Jellyfin + future Arr-style media automation. Alongside AI LXC, both planned to share a future external GPU. Bulk media on TrueNAS 8 TB mirror; local SSD for configs/cache/transcode. |
| **Disc Ripping Machine** | ESIMOER NUC or dedicated hardware | VM / bare metal | Research | ARM-style automated ripping workflow. Separate from Media LXC. Placement TBD.                                                                                                          |

## Service Architecture

### Main Host VMs and LXCs

#### catcord VM (192.168.1.59)

**Public:** catcord.duckdns.org (ports 80/443 forwarded)

Matrix homeserver and related services:

```
Caddy (80/443)           ← Reverse proxy with TLS
Conduit (127.0.0.1:6167) ← Matrix homeserver (localhost only)
Character API (8090)     ← Character card management
Identity API (8092)      ← User identity mapping
catcord-memory (internal)← Memory/RAG, docker-internal only (memory:8090 on catcord_internal)
catcord-online (internal)← RSS fetch, docker-internal only (online:8088 on catcord_internal)
Cleaner Event Bot        ← Event-driven media retention (always running)
Cleaner Bot              ← Scheduled/manual cleanup (restart: no)
News Bot (Delilah)       ← RSS aggregation (restart: no)
```

**Storage:**
- Root: 50GB
- /srv/media: 150GB (Matrix media only)

**Matrix Config:**
- Federation: OFF
- Registration: OFF (invite-only)
- Rooms: Unencrypted

#### GitRack LXC (192.168.1.61)

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

