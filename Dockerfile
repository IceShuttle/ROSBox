ARG ROS_DISTRO=humble
from docker.io/ros:${ROS_DISTRO}

ARG NVIM_VER="v0.12.1"

run apt-get update && apt-get install -y cppcheck clang clangd clang-format \
           ccache ninja-build lld curl wget tmux ripgrep fd-find \
           zsh zsh-autosuggestions zsh-syntax-highlighting

run (apt-get update && apt-get install -y zoxide) || (curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh && \
    mv /root/.local/bin/zoxide /usr/local/bin/zoxide)

run curl -sS https://starship.rs/install.sh | sh -s -- -y

run (wget -O /tmp/nvim.deb  https://github.com/neovim/neovim-releases/releases/download/${NVIM_VER}/nvim-linux-x86_64.deb \
 && dpkg -i /tmp/nvim.deb) || (apt-get update && apt-get remove -y neovim && apt-get install -y neovim)

run (apt-get update && apt-get install -y lsd) || (wget -O /tmp/lsd.deb https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-musl_1.2.0_amd64.deb \ 
 && dpkg -i /tmp/lsd.deb)

run apt-get update && apt-get install -y libwayland-cursor0 libxkbcommon0

run apt-get update && \
    apt-get install -y curl ca-certificates gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      | gpg --dearmor -o /etc/apt/keyrings/githubcli.gpg && \
    chmod go+r /etc/apt/keyrings/githubcli.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli.gpg] https://cli.github.com/packages stable main" \
      > /etc/apt/sources.list.d/github-cli.list && \
    apt-get update && \
    apt-get install -y gh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
