# cathyAI Homelab Documentation

Professional documentation for a Proxmox-based homelab infrastructure serving AI, Matrix, media, and storage services.

## Overview

This homelab runs on a 3-node Proxmox cluster designed to serve 1-2 users with:
- AI/LLM services (Ollama, NPU acceleration, unified orchestration)
- Matrix homeserver (Conduit) with AI-powered bots
- Unified prompt composition and memory services
- Secure storage (TrueNAS)
- Self-hosted utilities (Bitwarden, Jellyfin - planned)

## Documentation

- [01 - Current Infrastructure](docs/01-current-infrastructure.md)
- [02 - Hardware](docs/02-hardware.md)
- [03 - Services and Resources](docs/03-services-and-resources.md)
- [04 - Secrets Management](docs/04-secrets-management.md)
- [05 - Future Plans](docs/05-future-plans.md)
- [06 - Implementation Ideas](docs/06-implementation-ideas.md)

## Quick Links

- **catcord VM** (192.168.1.59): Character API, Identity API, Memory, Bots, WebUI
- **ESIMOER NUC**: Ollama workloads
- **ASUS NUC 15 Pro+**: NPU-accelerated AI services
- **Main Host**: TrueNAS storage, infrastructure services

## Last Updated

**Date:** 2026-03-04

---

*This documentation is maintained as a living reference for the cathyAI homelab infrastructure.*
