# Hardware

## Node Specifications

### Main Host

| Component | Specification |
|-----------|---------------|
| **CPU** | AMD Ryzen 5 5600G (6 cores, 12 threads) |
| **RAM** | 32GB DDR4 |
| **Boot Drive** | 512GB SSD |
| **Fast Storage** | 1TB SSD |
| **Bulk Storage** | Multiple HDDs (via HBA) |
| **Case** | Fractal Design Node 804 |
| **HBA Card** | PCIe HBA for direct HDD passthrough |
| **Role** | Storage host (TrueNAS), NPU-SVC, infrastructure, GitRack LXC |

---

### ESIMOER Intel NUC

| Component | Specification |
|-----------|---------------|
| **CPU** | Intel Core i5-1235U (10 cores: 2P + 8E) |
| **RAM** | 64GB DDR5 |
| **Storage** | 1TB NVMe SSD |
| **Form Factor** | Mini PC / NUC |
| **Role** | Dedicated Ollama inference |

---

### ASUS NUC 15 Pro+

| Component | Specification |
|-----------|---------------|
| **CPU** | Intel Core Ultra 5 225H |
| **NPU** | Integrated Neural Processing Unit |
| **RAM** | 32GB DDR5 |
| **Storage** | 1TB NVMe SSD |
| **Form Factor** | Mini PC / NUC |
| **Role** | NPU-accelerated AI, ai-orchestrator |

---

## Node Role Summary

| Node | Storage | Compute | AI Services |
|------|---------|---------|-------------|
| **Main Host** | Primary (TrueNAS) | Light | NPU-SVC |
| **ESIMOER NUC** | Local | Medium | Ollama |
| **ASUS NUC 15 Pro+** | Local | Medium | NPU-SVC, ai-orchestrator |
