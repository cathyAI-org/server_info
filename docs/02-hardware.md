# Hardware

## Proxmox Cluster Nodes

### DIY PC Proxmox Node (Main Host)

**PCPartPicker:** [https://se.pcpartpicker.com/list/y6bGBq](https://se.pcpartpicker.com/list/y6bGBq)

| Component | Specification |
|-----------|---------------|
| **CPU** | [AMD Ryzen 5 5600G 3.9 GHz 6-Core](https://se.pcpartpicker.com/product/sYmmP6/amd-ryzen-5-5600g-39-ghz-6-core-processor-100-100000252box) |
| **CPU Cooler** | [Noctua NH-C14S 82.52 CFM](https://se.pcpartpicker.com/product/kykwrH/noctua-nh-c14s-8252-cfm-cpu-cooler-nh-c14s) |
| **Motherboard** | [MSI B550M PRO-VDH Micro ATX AM4](https://se.pcpartpicker.com/product/DLcG3C/msi-b550m-pro-vdh-micro-atx-am4-motherboard-b550m-pro-vdh) |
| **Memory** | 32 GB (2 x 16 GB) DDR4-3200 |
| **Boot Drive** | [Kingston NV3 500 GB M.2 NVMe](https://se.pcpartpicker.com/product/px7scf/kingston-nv3-500-gb-m2-2280-pcie-40-x4-nvme-solid-state-drive-snv3s500g) |
| **Fast Storage** | [WD Black SN750 1 TB M.2 NVMe](https://se.pcpartpicker.com/product/QQrmP6/western-digital-wd_black-sn750-1-tb-m2-2280-nvme-solid-state-drive-wds100t3x0c) |
| **HDD 1** | [WD Red 4 TB 3.5" 5400 RPM](https://se.pcpartpicker.com/product/rkV48d/western-digital-internal-hard-drive-wd40efrx) |
| **HDD 2** | [Seagate IronWolf NAS 4 TB 3.5" 5400 RPM](https://se.pcpartpicker.com/product/6FQcCJ/seagate-ironwolf-nas-4-tb-35-5400-rpm-internal-hard-drive-st4000vn006) |
| **HDD 3** | [Seagate Constellation ES 2 TB 3.5" 7200 RPM](https://se.pcpartpicker.com/product/JnvRsY/seagate-internal-hard-drive-st32000644ns) |
| **HDD 4** | [Seagate Constellation ES 2 TB 3.5" 7200 RPM](https://se.pcpartpicker.com/product/JnvRsY/seagate-internal-hard-drive-st32000644ns) |
| **Case** | [Fractal Design Node 804 MicroATX](https://se.pcpartpicker.com/product/yTdqqs/fractal-design-case-fdcanode804blw) |
| **PSU** | [Fractal Design Ion Gold 850 W 80+ Gold](https://se.pcpartpicker.com/product/8ZJgXL/fractal-design-ion-gold-850-w-80-gold-certified-fully-modular-atx-power-supply-fd-p-ia2g-850) |
| **Case Fans** | 2 x [Noctua P12 PWM 120 mm](https://se.pcpartpicker.com/product/Z7mLrH/noctua-case-fan-nfp12pwm), 1 x [Noctua P14s redux-1200 PWM 140 mm](https://se.pcpartpicker.com/product/xs6BD3/noctua-case-fan-nfp14sredux1200pwm) |
| **HBA Card** | 9207-8i PCIe 3.0 6Gbps HBA LSI (SAS2308) |

**Role:** General services (TrueNAS VM, GitRack LXC, infrastructure)  
**Storage Note:** HBA currently managed by host. See [Future Plans - HBA Passthrough](05-future-plans.md#13-hba-passthrough-storage-mode) for proposed PCIe passthrough to TrueNAS VM with power-saving disk management.

---

### ASUS NUC 15 Pro+

**Source:** Purchased used on Tradera

| Component | Specification |
|-----------|---------------|
| **CPU** | Intel Core Ultra 5 225H (14-core, 1.7 GHz base, up to 4.9 GHz) |
| **NPU** | Intel AI Boost (up to 13 TOPS) |
| **GPU** | Intel Arc Graphics 130T (up to 63 TOPS) |
| **RAM** | 32 GB DDR5 (max 96 GB) |
| **Storage** | 1 TB SSD |
| **Network** | 1GbE, 2.5GbE, Wi-Fi 7, Bluetooth |
| **OS** | Proxmox VE |
| **Security** | Firmware TPM |
| **Form Factor** | Mini PC / NUC |

**Role:** NPU-SVC, NPU-accelerated AI, ai-orchestrator  
**Status:** New/unused, purchased used

---

### ESIMOER Intel NUC

**Product Link:** [Amazon SE](https://www.amazon.se/dp/B0DBCZFCWK)

| Component | Specification |
|-----------|---------------|
| **CPU** | Intel Core i5-1235U (12th Gen, 10 cores: 2P + 8E, up to 4.4 GHz) |
| **RAM** | DDR5 SO-DIMM (2 slots, max 64 GB) |
| **Storage** | 2 x M.2 SSD (NVME1: Gen3/SATA, NVME2: Gen4, max 4TB each) |
| **Storage** | 1 x SATA 3.0 for 2.5" HDD/SSD (max 6TB, ≤7mm) |
| **Network** | 2 x RJ45 2.5G LAN, Wi-Fi 6, Bluetooth 5.2 |
| **Display** | Triple display: HDMI (4K@60Hz), DP (8K@30Hz/4K@60Hz), Type-C (4K@60Hz) |
| **Ports** | 2 x USB 2.0, 6 x USB 3.2, 1 x Type-C, 1 x DP, 1 x HDMI |
| **OS** | Proxmox VE |
| **Form Factor** | Mini PC / NUC |

**Role:** General compute, Ollama services frontend  
**Included:** Power adapter, power cord, 2 x SATA cables, HD cable, VESA mounting, user guide

---

## Client & Gaming Systems

### Main Work/Gaming PC

**PCPartPicker:** [https://se.pcpartpicker.com/list/YcVgsK](https://se.pcpartpicker.com/list/YcVgsK)  
**OS:** Windows 10 (exploring CachyOS)

| Component | Specification |
|-----------|---------------|
| **CPU** | [AMD Ryzen 7 5800X 3.8 GHz 8-Core](https://se.pcpartpicker.com/product/qtvqqs/amd-ryzen-7-5800x-38-ghz-8-core-processor-100-100000063wof) |
| **CPU Cooler** | [Noctua NH-U12A 60.09 CFM](https://se.pcpartpicker.com/product/ZLtQzy/noctua-nh-u12a-6009-cfm-cpu-cooler-nh-u12a) |
| **Motherboard** | [Gigabyte B550 AORUS ELITE AX V2 ATX](https://se.pcpartpicker.com/product/Vb3mP6/gigabyte-b550-aorus-elite-ax-v2-atx-am4-motherboard-b550aorus-elite-axv2) |
| **Memory** | 96 GB (2 x 32 GB + 2 x 16 GB) [Kingston FURY Beast DDR4-3200](https://se.pcpartpicker.com/product/3q2WGX/kingston-fury-beast-32-gb-2-x-16-gb-ddr4-3200-cl16-memory-kf432c16bbk232) |
| **Storage** | [Samsung 870 Evo 1 TB 2.5" SSD](https://se.pcpartpicker.com/product/7nsnTW/samsung-870-evo-1-tb-25-solid-state-drive-mz-77e1t0bam) |
| **Storage** | [Samsung 980 Pro w/Heatsink 2 TB M.2 NVMe](https://se.pcpartpicker.com/product/fVC48d/samsung-980-pro-heatsink-2-tb-m2-2280-nvme-solid-state-drive-mz-v8p2t0cw) |
| **Storage** | [Seagate BarraCuda 2 TB 3.5" 7200 RPM](https://se.pcpartpicker.com/product/CbL7YJ/seagate-barracuda-2tb-35-7200rpm-internal-hard-drive-st2000dm006) |
| **GPU 1** | [MSI VENTUS 2X OC GeForce RTX 4070 12 GB](https://se.pcpartpicker.com/product/NHzXsY/msi-ventus-2x-oc-geforce-rtx-4070-12-gb-video-card-rtx-4070-ventus-2x-12g-oc) |
| **GPU 2** | [Gigabyte GAMING OC Radeon RX 9060 XT 16 GB](https://se.pcpartpicker.com/product/TcG2FT/gigabyte-gaming-oc-radeon-rx-9060-xt-16-gb-video-card-gv-r9060xtgaming-oc-16gd) |
| **Case** | [Fractal Design North ATX Mid Tower](https://se.pcpartpicker.com/product/sHYmP6/fractal-design-north-atx-mid-tower-case-fd-c-nor1c-01) |
| **PSU** | [Corsair RM1000e (2022) 1000 W 80+ Gold](https://se.pcpartpicker.com/product/KnYmP6/corsair-rm1000e-2022-1000-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020250-na) |
| **Case Fans** | 5 x Noctua (A14 PWM, P12 PWM, P14s redux, A14 industrialPPC) |
| **Monitor 1** | [Asus PB278Q 27.0" 2560x1440 60Hz](https://se.pcpartpicker.com/product/LVV48d/asus-monitor-pb278q) |
| **Monitor 2** | [HP OMEN 25i 24.5" 1920x1080 165Hz](https://se.pcpartpicker.com/product/BPD7YJ/hp-omen-25i-245-1920x1080-165-hz-monitor-22j05aaaba) |
| **Keyboard** | [Keychron Q6 Pro RGB](https://se.pcpartpicker.com/product/VFQKHx/keychron-q6-pro-rgb-bluetoothwirelesswired-gaming-keyboard-q6p-m1) |
| **Mouse** | [Corsair Scimitar Elite SE](https://se.pcpartpicker.com/product/hbCCmG/corsair-scimitar-elite-se-bluetoothwireless-optical-mouse-ch-9314014-ww) |
| **Headphones** | HP HyperX Cloud III Headset |

**Network:** Cat 8 Ethernet to Ubiquiti Dream Router 7

---

### Console Gaming PC

**PCPartPicker:** [https://se.pcpartpicker.com/list/C4FHwY](https://se.pcpartpicker.com/list/C4FHwY)  
**OS:** Bazzite

| Component | Specification |
|-----------|---------------|
| **CPU** | [AMD Ryzen 5 5600 3.5 GHz 6-Core](https://se.pcpartpicker.com/product/PgcG3C/amd-ryzen-5-5600-36-ghz-6-core-processor-100-100000927box) |
| **CPU Cooler** | [Noctua NH-L9a-AM4 33.84 CFM](https://se.pcpartpicker.com/product/DZfhP6/noctua-nh-l9a-am4-3384-cfm-cpu-cooler-nh-l9a-am4) |
| **Motherboard** | [MSI B550M PRO-VDH WIFI Micro ATX](https://se.pcpartpicker.com/product/PDsnTW/msi-b550m-pro-vdh-wifi-micro-atx-am4-motherboard-b550m-pro-vdh-wifi) |
| **Memory** | 32 GB (2 x 16 GB) DDR4-3200 |
| **Storage** | [Crucial P3 Plus 1 TB M.2 NVMe](https://se.pcpartpicker.com/product/chzhP6/crucial-p3-plus-1-tb-m2-2280-nvme-solid-state-drive-ct1000p3pssd8) |
| **Storage** | [Seagate BarraCuda 4 TB 3.5" 5400 RPM](https://se.pcpartpicker.com/product/jD3H99/seagate-barracuda-4tb-35-5400rpm-internal-hard-drive-st4000dm004) |
| **GPU** | [Sapphire PULSE Radeon RX 7600 8 GB](https://se.pcpartpicker.com/product/xC88TW/sapphire-pulse-radeon-rx-7600-xt-8-gb-video-card-11324-01-20g) |
| **Case** | [Lian Li A3-mATX MicroATX Mini Tower](https://se.pcpartpicker.com/product/FG7scf/lian-li-a3-matx-microatx-mini-tower-case-a3-matx-wd-black) |
| **PSU** | [Corsair RM650e (2025) 650 W](https://se.pcpartpicker.com/product/6TBFf7/corsair-rm650e-2025-650-w-fully-modular-atx-power-supply-cp-9020302-na) |
| **Case Fans** | 3 x [Noctua NF-A12x25 G2 PWM 120 mm](https://se.pcpartpicker.com/product/XLpD4D/noctua-nf-a12x25-g2-pwm-6315-cfm-120-mm-fan-nf-a12x25-g2-pwm) |

**Network:** Cat 6/6a Ethernet to TP-Link TL-SG105 switch

---

### Emulation PC

**PCPartPicker:** [https://se.pcpartpicker.com/list/LtPvgn](https://se.pcpartpicker.com/list/LtPvgn)  
**OS:** Batocera

| Component | Specification |
|-----------|---------------|
| **CPU** | [AMD Ryzen 5 5500 3.6 GHz 6-Core](https://se.pcpartpicker.com/product/yq2WGX/amd-ryzen-5-5500-36-ghz-6-core-processor-100-100000457box) |
| **CPU Cooler** | [Noctua NH-L12S 55.44 CFM](https://se.pcpartpicker.com/product/hbnG3C/noctua-nh-l12s-5544-cfm-cpu-cooler-nh-l12s) |
| **Motherboard** | [Gigabyte A520I AC Mini ITX](https://se.pcpartpicker.com/product/s6tKHx/gigabyte-a520i-ac-mini-itx-am4-motherboard-a520i-ac) |
| **Memory** | [Netac Shadow II 32 GB (2 x 16 GB) DDR4-3200](https://se.pcpartpicker.com/product/ttHqqs/netac-shadow-ii-32-gb-2-x-16-gb-ddr4-3200-cl16-memory-ntswd4p32dp-32k) |
| **Storage** | [Crucial P3 Plus 1 TB M.2 NVMe](https://se.pcpartpicker.com/product/chzhP6/crucial-p3-plus-1-tb-m2-2280-nvme-solid-state-drive-ct1000p3pssd8) |
| **Storage** | [Toshiba P300 4 TB 3.5" 5400 RPM](https://se.pcpartpicker.com/product/2bPQzy/toshiba-p300-4-tb-35-5400rpm-internal-hard-drive-hdwd240uzsva) |
| **GPU** | [XFX Speedster SWFT 210 Radeon RX 6600 XT 8 GB](https://se.pcpartpicker.com/product/tWJgXL/xfx-radeon-rx-6600-xt-8-gb-speedster-swft-210-video-card-rx-66xt8dfdq) |
| **Case** | [Fractal Design Mood Mini ITX Tower](https://se.pcpartpicker.com/product/bb3NnQ/fractal-design-mood-mini-itx-tower-case-fd-c-mod1n-02) |
| **PSU** | [Cooler Master V650 SFX GOLD 650 W](https://se.pcpartpicker.com/product/DhRgXL/cooler-master-v650-sfx-gold-650-w-80-gold-certified-fully-modular-sfx-power-supply-mpy-6501-sfhagv-us) |
| **Case Fan** | [Noctua A12x25 PWM 120 mm](https://se.pcpartpicker.com/product/zxx2FT/noctua-nf-a12x25-pwm-601-cfm-120mm-fan-nf-a12x25-pwm) |

**Network:** Cat 6/6a Ethernet to TP-Link TL-SG105 switch

---

## Network Infrastructure

### Switches

#### SODOLA 8-Port 2.5GbE Switch

**Product Link:** [Amazon SE](https://www.amazon.se/dp/B0CW19NW98)

| Specification | Details |
|---------------|---------|
| **Ports** | 8 x 2.5GBASE-T + 1 x 10G SFP+ |
| **Switching Capacity** | 100 Gbps |
| **Design** | Fan-free, metal housing |
| **Type** | Unmanaged, plug & play |
| **Connected Devices** | Synology NAS, RPi4, Philips TV, Zyxel switch, TP-Link switch |
| **Uplink** | 10G SFP+ to Ubiquiti Dream Router 7 |

**Role:** Central backbone switch connected to router via 10G SFP+

---

#### Zyxel 5-Port Gigabit Switch

**Product Link:** [Amazon SE](https://www.amazon.se/dp/B0DNZGFJ21)

| Specification | Details |
|---------------|---------|
| **Ports** | 5 x 10/100/1000 Mbps RJ45 |
| **Design** | Metal housing, silent operation |
| **Type** | Unmanaged, plug & play |
| **Features** | QoS ports, green energy efficiency |
| **Connected Devices** | ASUS NUC 15 Pro+, ESIMOER Intel NUC |

**Role:** Connects ASUS NUC and ESIMOER NUC to SODOLA 2.5GbE switch

---

#### TP-Link TL-SG105 5-Port Gigabit Switch

**Product Link:** [Amazon SE](https://www.amazon.se/-/en/TP-Link-TL-SG105-Gigabit-Ethernet-Wall-Mount/dp/B00A128S24)

| Specification | Details |
|---------------|---------|
| **Ports** | 5 x 10/100/1000 Mbps |
| **Design** | Metal housing, fanless |
| **Type** | Unmanaged, plug & play |
| **Features** | 802.1p/DSCP QoS, IGMP snooping |
| **Connected Devices** | Console Gaming PC, Emulation PC |

**Role:** Gaming and emulation systems network

---

### Router

#### Ubiquiti Dream Router 7 (UDR7)

**Model:** UDR7  
**Wi-Fi Generation:** Wi-Fi 7

| Specification | Details |
|---------------|---------|
| **Frequency** | Tri-Band (6 GHz) |
| **Wireless Standard** | 802.11be (Wi-Fi 7) |
| **Data Transfer Rate** | 5700 Mbps |
| **LAN Port Bandwidth** | 2500 Mbps (2.5GbE) |
| **RAM** | 3 GB |
| **Antennas** | 3 internal |
| **Security** | WPA-PSK, WPA2-PSK, WPA3, WPA-Enterprise, PPSK |
| **OS** | UniFi OS |
| **Coverage** | 160 m² |
| **Voice Control** | Amazon Alexa, Google Assistant |

**Role:** Main router and Wi-Fi 7 access point

---

### Cabling

- **10G SFP+:** Ubiquiti Dream Router 7 → SODOLA 2.5GbE Switch
- **Cat 8:** Main Work/Gaming PC → Ubiquiti Dream Router 7
- **Cat 6a:** DIY Proxmox Node → Ubiquiti Dream Router 7, Synology NAS, NUCs, switch interconnects
- **Cat 6:** RPi4, Philips TV, gaming PCs
- **Topology:** High-priority devices direct to router, others via SODOLA switch

---

## External Hardware

### Raspberry Pi 4 (8GB)

| Component | Specification |
|-----------|---------------|
| **Model** | Raspberry Pi 4 Model B |
| **RAM** | 8 GB |
| **Storage** | 64 GB SD card |
| **Current Role** | Home Assistant (standalone) |
| **Status** | Running stable for ~1 year |
| **Network** | Connected to SODOLA switch |
| **Future** | Planned migration to Proxmox HAOS VM, then cold spare or repurposed |

---

### Synology NAS

| Component | Specification |
|-----------|---------------|
| **Type** | Network Attached Storage |
| **Network** | Connected to SODOLA 2.5GbE switch |
| **Role** | Additional storage and backup |

---

### Eufy HomeBase 3 + EufyCam 3C (3-pack)

**Product Link:** [Elgiganten](https://www.elgiganten.se/product/hem-hushall-tradgard/sakerhet-overvakning/overvakningskamera/eufy-eufycam-3c-4k-overvakningskamera-3-pack/756863)

| Specification | Details |
|---------------|---------|
| **Cameras** | 3 x EufyCam 3C 4K |
| **Resolution** | 4K UHD (2160p) |
| **Field of View** | 135° horizontal |
| **Night Vision** | Yes |
| **Storage** | 16 GB eMMC (local) |
| **Battery Life** | ~6 months |
| **IP Rating** | IP67 |
| **Connectivity** | Wi-Fi to HomeBase 3 |
| **Voice Control** | Amazon Alexa, Google Assistant |
| **Subscription** | Not required |

**Role:** Home security and surveillance

---

### Philips 50" PUS8500 4K QLED Smart TV (2025)

**Product Link:** [Elgiganten](https://www.elgiganten.se/product/tv-ljud-smart-hem/tv-tillbehor/tv/philips-50-pus8500-4k-qled-smart-tv-2025/914112)

| Specification | Details |
|---------------|---------|
| **Screen Size** | 50" (126 cm) |
| **Panel Type** | QLED |
| **Resolution** | 4K UHD (3840x2160) |
| **Refresh Rate** | 60 Hz |
| **HDR** | HDR10+, HLG |
| **Processor** | Pixel Precise Ultra HD |
| **Smart Platform** | TITAN OS |
| **HDMI** | 3 x HDMI 2.1 (eARC, VRR, ALLM) |
| **USB** | 2 ports |
| **Audio** | 20 W |
| **Network** | Wi-Fi 4, Bluetooth, Ethernet (connected to SODOLA switch) |
| **Voice Control** | Google Assistant, Alexa |

**Role:** Media consumption and smart home display

---

## Hardware Summary

### System Count

- **Proxmox Nodes:** 3 (DIY PC, ASUS NUC, ESIMOER NUC)
- **Client PCs:** 3 (Main Work/Gaming, Console Gaming, Emulation)
- **Network Switches:** 3 (SODOLA 2.5GbE, Zyxel 5-port, TP-Link 5-port)
- **Router:** 1 (Ubiquiti Dream Router 7)
- **IoT Devices:** Raspberry Pi 4, Synology NAS, Eufy HomeBase 3 + 3 cameras, Philips TV

---

*For network topology and service allocation, see [Current Infrastructure](01-current-infrastructure.md) and [Services and Resources](03-services-and-resources.md).*
