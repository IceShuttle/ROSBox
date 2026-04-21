ARG ROS_DISTRO=humble
from ros:${ROS_DISTRO}
run apt-get update && apt-get install -y cppcheck clang clangd clang-format \
           ccache ninja-build lld
run apt-get update && apt-get install -y wget tmux ripgrep fd-find \
           zsh zsh-autosuggestions zsh-syntax-highlighting zoxide
run curl -sS https://starship.rs/install.sh | sh -s -- -y
run wget -O /tmp/nvim.deb  https://github.com/neovim/neovim-releases/releases/download/v0.12.1/nvim-linux-x86_64.deb \
 && dpkg -i /tmp/nvim.deb
run wget -O /tmp/lsd.deb https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-musl_1.2.0_amd64.deb \ 
 && dpkg -i /tmp/lsd.deb
