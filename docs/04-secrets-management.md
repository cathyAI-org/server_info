# Secrets Management

## ⚠️ WARNING

**NEVER commit real secrets to version control.**

This file is a template. Copy to `.env` files in each service directory and fill in actual values locally.

---

## Character API

```bash
CHAR_API_KEY=[TO_BE_FILLED]
HOST_URL=http://192.168.1.59:8090
CHAR_DIR=/app/characters
PORT=8090
```

---

## Identity API

```bash
IDENTITY_API_KEY=[TO_BE_FILLED]
HOST_URL=http://192.168.1.59:8092
PORT=8092
DATABASE_URL=[TO_BE_FILLED]
```

---

## catcord-memory

Docker-internal only on `catcord_internal` network (no host-exposed port).  
Accessed by other containers as `memory:8090`.

```bash
IDENTITY_API_URL=http://identity_api_identity_api_1:8092
IDENTITY_API_KEY=[TO_BE_FILLED]
IDENTITY_API_TIMEOUT_S=3
```

---

## prompt-composer

```bash
PROMPT_COMPOSER_API_KEY=[TO_BE_FILLED]
HOST_URL=http://192.168.1.57:8110
PORT=8110
CHARACTER_API_URL=http://192.168.1.59:8090
IDENTITY_API_URL=http://192.168.1.59:8092
CHARACTER_API_KEY=[TO_BE_FILLED]
IDENTITY_API_KEY=[TO_BE_FILLED]
```

---

## ollama-api

From `cathyAI-infra` repo (container: `cathyai-api`). The standalone `cathyAI-API` repo is superseded.

```bash
OLLAMA_API_KEY=[TO_BE_FILLED]
HOST_URL=http://192.168.1.57:8100
PORT=8100
OLLAMA_BACKEND_URL=http://192.168.1.57:11434
```

---

## ai-orchestrator

```bash
ORCHESTRATOR_API_KEY=[TO_BE_FILLED]
HOST_URL=http://192.168.1.57:8120
PORT=8120
OLLAMA_API_URL=http://192.168.1.57:8100
NPU_SVC_URL=http://192.168.1.55:8010
OLLAMA_API_KEY=[TO_BE_FILLED]
NPU_SVC_API_KEY=[TO_BE_FILLED]
```

---

## Chainlit WebUI

> **Unverified:** ESIMOER NUC is currently offline. The `cathyAI-webui` repo documents
> Chainlit on 8000, auth API on 8001, and wakeup proxy on 7999 with env vars
> `CHAT_API_URL`, `MODELS_API_URL`, `CHAR_API_URL`, `IDENTITY_API_URL`. Verify
> when node is back online.

```bash
CHAINLIT_AUTH_SECRET=[TO_BE_FILLED]
CHAINLIT_URL=http://192.168.1.60:8000
PORT=8000

USER_1_USERNAME=[TO_BE_FILLED]
USER_1_PASSWORD=[TO_BE_FILLED]
USER_2_USERNAME=[TO_BE_FILLED]
USER_2_PASSWORD=[TO_BE_FILLED]

PROMPT_COMPOSER_URL=http://192.168.1.57:8110
AI_ORCHESTRATOR_URL=http://192.168.1.57:8120
CHARACTER_API_URL=http://192.168.1.59:8090
IDENTITY_API_URL=http://192.168.1.59:8092

PROMPT_COMPOSER_API_KEY=[TO_BE_FILLED]
AI_ORCHESTRATOR_API_KEY=[TO_BE_FILLED]
CHARACTER_API_KEY=[TO_BE_FILLED]
IDENTITY_API_KEY=[TO_BE_FILLED]
```

---

## Matrix Conduit

```bash
CONDUIT_SERVER_NAME=[TO_BE_FILLED]
CONDUIT_DATABASE_PATH=/var/lib/matrix-conduit
CONDUIT_PORT=6167
CONDUIT_ADDRESS=0.0.0.0
CONDUIT_MAX_REQUEST_SIZE=20000000
CONDUIT_ALLOW_REGISTRATION=false
CONDUIT_ALLOW_FEDERATION=false
CONDUIT_TRUSTED_SERVERS=["matrix.org"]
```

---

## Cleaner Bot (Irina)

```bash
BOT_HOMESERVER=http://192.168.1.59:6167
BOT_MXID=@irina:[YOUR_HOMESERVER]
BOT_ACCESS_TOKEN=[TO_BE_FILLED]
BOT_DISPLAY_NAME=Irina
BOT_AVATAR_URL=[TO_BE_FILLED]

PROMPT_COMPOSER_URL=http://192.168.1.57:8110
AI_ORCHESTRATOR_URL=http://192.168.1.57:8120
PROMPT_COMPOSER_API_KEY=[TO_BE_FILLED]
AI_ORCHESTRATOR_API_KEY=[TO_BE_FILLED]

CHARACTER_ID=char_irina_001
CLEAN_DELAY_SECONDS=300
ALLOWED_ROOMS=[TO_BE_FILLED]
```

---

## News Bot (Delilah)

```bash
BOT_HOMESERVER=http://192.168.1.59:6167
BOT_MXID=@delilah:[YOUR_HOMESERVER]
BOT_ACCESS_TOKEN=[TO_BE_FILLED]
BOT_DISPLAY_NAME=Delilah
BOT_AVATAR_URL=[TO_BE_FILLED]

PROMPT_COMPOSER_URL=http://192.168.1.57:8110
AI_ORCHESTRATOR_URL=http://192.168.1.57:8120
PROMPT_COMPOSER_API_KEY=[TO_BE_FILLED]
AI_ORCHESTRATOR_API_KEY=[TO_BE_FILLED]

CHARACTER_ID=char_delilah_001
RSS_FEEDS=[TO_BE_FILLED]
POST_INTERVAL_MINUTES=60
TARGET_ROOM=[TO_BE_FILLED]
```

---

## Ollama

```bash
OLLAMA_HOST=0.0.0.0:11434
OLLAMA_MODELS=/root/.ollama/models
OLLAMA_KEEP_ALIVE=5m
```

---

## NPU-SVC

```bash
NPU_SVC_API_KEY=[TO_BE_FILLED]
NPU_SVC_PORT=8010
NPU_SVC_HOST=0.0.0.0
NPU_DEVICE=auto
MODEL_CACHE_DIR=/app/models
```

---

## TrueNAS

```bash
TRUENAS_API_KEY=[TO_BE_FILLED]
TRUENAS_HOST=http://[TRUENAS_IP]
```

---

## Tailscale

```bash
TAILSCALE_AUTH_KEY=[TO_BE_FILLED]
TAILSCALE_HOSTNAME=[TO_BE_FILLED]
```

---

## WireGuard

```bash
WG_PRIVATE_KEY=[TO_BE_FILLED]
WG_PUBLIC_KEY=[TO_BE_FILLED]
WG_ENDPOINT=[TO_BE_FILLED]
WG_ALLOWED_IPS=192.168.1.0/24
```

---

## Bitwarden

```bash
ADMIN_TOKEN=[TO_BE_FILLED]
DATABASE_URL=[TO_BE_FILLED]
DOMAIN=https://[YOUR_DOMAIN]
SMTP_HOST=[TO_BE_FILLED]
SMTP_FROM=[TO_BE_FILLED]
SMTP_USERNAME=[TO_BE_FILLED]
SMTP_PASSWORD=[TO_BE_FILLED]
```

---

## Media LXC — Jellyfin (Planned)

Planned for the ASUS NUC Media LXC. Bulk media on TrueNAS 16 TB RAID1 mirror.

```bash
JELLYFIN_PUBLISHED_SERVER_URL=http://[MEDIA_LXC_IP]:8096
JELLYFIN_DATA_DIR=/config
JELLYFIN_CACHE_DIR=/cache
```

> Additional env vars for Arr-style automation services (Sonarr, Radarr, etc.) will be documented when the stack is deployed.

---

## Best Practices

1. Never commit `.env` files - Add to `.gitignore`
2. Generate strong keys: `openssl rand -hex 32`
3. Rotate secrets regularly
4. Backup secrets securely (encrypted storage)
5. One key per service, not shared
6. Document secret purpose with comments
