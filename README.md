# cathyAI Homelab Documentation

Professional documentation for a Proxmox-based homelab infrastructure serving AI, Matrix, media, and storage services.

## Overview

This homelab runs on a 3-node Proxmox cluster designed to serve 1-2 users with:
- AI/LLM services (Ollama, NPU acceleration, unified orchestration)
- Matrix homeserver (Conduit) with AI-powered bots
- Unified prompt composition and memory services
- Secure storage (TrueNAS)
- Self-hosted utilities (Bitwarden)
- Media services roadmap (planned Media LXC on ASUS NUC with TrueNAS-backed storage, separate disc ripping research track)

## Documentation

- [01 - Current Infrastructure](docs/01-current-infrastructure.md)
- [02 - Hardware](docs/02-hardware.md)
- [03 - Services and Resources](docs/03-services-and-resources.md)
- [04 - Secrets Management](docs/04-secrets-management.md)
- [05 - Future Plans](docs/05-future-plans.md)
- [06 - Implementation Ideas](docs/06-implementation-ideas.md)
- [07 - Development Standards](docs/07-development-standards.md)

## Quick Links

- **Proxmox Main Host** (192.168.1.51): TrueNAS VM, GitRack LXC, infrastructure services
- **TrueNAS VM** (192.168.1.17): Bulk storage, backups
- **Home Assistant VM** (192.168.1.52): Smart home (migrated from RPi4)
- **ASUS NUC 15 Pro+** (192.168.1.55): NPU-SVC, Ollama API, AI Orchestrator, Prompt Composer
- **Prompt Composer** (192.168.1.57:8110): Unified prompt assembly (on ASUS NUC)
- **catcord VM** (192.168.1.59 / catcord.duckdns.org): Matrix Conduit, Character API, Identity API, Memory, Bots
- **ESIMOER NUC** (192.168.1.60): Chainlit WebUI
- **GitRack LXC** (192.168.1.61): Forgejo + RackPeek
- **WireGuard** (192.168.1.63): VPN
- **Tailscale** (192.168.1.64): VPN
- **Bitwarden** (192.168.1.65): Password manager

## Last Updated

**Date:** 2026-03-04

---

*This documentation is maintained as a living reference for the cathyAI homelab infrastructure.*
