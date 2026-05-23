# 🤖 ROS 2 Humble(Defualt) Distrobox Dev Environment

A streamlined, containerized development environment for **ROS 2 Humble(Default)** using **Distrobox** + **Podman/Docker**, pre-configured with essential development tools, a polished terminal experience, and optional NVIDIA GPU support.

> ✨ Perfect for ROS 2 development on Linux workstations with host-like performance and easy reproducibility.

---

## 🚀 Features

- 🐳 **Containerized ROS 2 Humble(Default)**: Isolated, reproducible environment based on official `ros:humble` image
- 🔧 **Pre-installed Dev Tools**: Clang/LLVM toolchain, `cppcheck`, `ccache`, `ninja`, `lld`
- ⚡ **Enhanced Terminal**: `zsh` + `starship` prompt + `zsh-autosuggestions` + `zsh-syntax-highlighting`
- 🗂️ **Modern CLI Utilities**: `ripgrep`, `fd-find`, `lsd`, `zoxide`, `tmux`
- ✏️ **Neovim v0.12.1**: Pre-installed from official releases for powerful in-container editing
- 🎮 **Optional NVIDIA Support**: GPU acceleration for perception/ML workloads via `--nvidia` flag
- 🔄 **Easy Lifecycle Management**: `make build` / `enter` / `refresh` for quick setup and resets

---

## 📋 Prerequisites

Ensure the following are installed on your host system:

```bash
# Distrobox (required)
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

# Podman (default) or Docker
sudo apt install podman  # OR: sudo apt install docker.io

# Optional: NVIDIA Container Toolkit (for GPU support)
 https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
```

> 💡 **Note**: If using Docker, set `RUNTIME=docker` in your `make` commands or export it as an env var.

---

## 🛠️ Quick Start

### 1. Clone & Build
```bash
git clone <your-repo-url>
cd <repo-directory>

# Build the container image and enter the environment
make enter
```

### 2. (Optional) Enable NVIDIA GPU Support
```bash
make enter NVIDIA=1
```

### 3. (Optional) Use a Different ROS Distro
```bash
make enter ROS_DISTRO=iron
```

---

## 📦 Available Make Targets

| Target | Description |
|--------|-------------|
| `make build` | Build the container image only |
| `make create` | Build (if needed) + create distrobox container |
| `make enter` | **Recommended**: Create + enter the dev environment |
| `make refresh` | Force-remove container + rebuild + re-enter (clean slate) |
| `make enter ROS_DISTRO=iron` | Override default ROS distro at runtime |
| `make enter NVIDIA=1` | Enable NVIDIA runtime flags |

> 💡 The `enter` target automatically handles dependencies (`create` → `build`).

---

## 🧰 Included Tools & Customizations

### 🧱 Build & Linting
| Tool | Purpose |
|------|---------|
| `clang`, `clangd`, `clang-format` | C++ compilation, LSP, formatting |
| `cppcheck` | Static code analysis |
| `ccache` | Compiler caching for faster rebuilds |
| `ninja-build`, `lld` | Fast build system & linker |

### 🖥️ Terminal & Shell
| Tool | Purpose |
|------|---------|
| `zsh` | Enhanced shell with plugin support |
| `zsh-autosuggestions` | Fish-like command suggestions |
| `zsh-syntax-highlighting` | Real-time syntax highlighting |
| `starship` | Cross-shell, customizable prompt |
| `zoxide` | Smarter `cd` with frecency tracking |
| `tmux` | Terminal multiplexer for persistent sessions |

### 🔍 CLI Enhancements
| Tool | Purpose |
|------|---------|
| `ripgrep` (`rg`) | Blazing-fast grep alternative |
| `fd-find` (`fd`) | Simple, fast `find` replacement |
| `lsd` | `ls` with icons, colors, and tree view |
| `gh` | GitHub CLI for PRs, issues, and repos |

### ✏️ Editor
| Tool | Version | Source |
|------|---------|--------|
| **Neovim** | v0.12.1 | [Official Releases](https://github.com/neovim/neovim-releases) |

### 🖼️ GUI Support Libraries
- `libwayland-cursor0`, `libxkbcommon0` – Enable GUI app compatibility inside container

---

## ⚙️ Customization

### Modify Installed Packages
Edit the `Dockerfile` to add/remove `apt-get install` packages or change tool versions.

### Change Default Runtime
```bash
make enter RUNTIME=docker 
```


---

## ❓ Troubleshooting

### 🔹 NVIDIA GPU not detected
1. Verify host has NVIDIA drivers + `nvidia-container-toolkit` installed
2. Test with:
   ```bash
   podman run --rm --nvidia nvidia/cuda:12.4.1-base-ubuntu22.04 nvidia-smi
   ```
3. Use `NVIDIA=1` flag: `make enter NVIDIA=1`

