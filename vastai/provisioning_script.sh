#!/bin/bash

cd /workspace/
# Cause the script to exit on failure.
set -eo pipefail

# Activate the main virtual environment
. /venv/main/bin/activate

# Detect system architecture
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    NVIM_ARCH="x86_64"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    NVIM_ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

echo "Detected architecture: $ARCH, downloading nvim-linux-${NVIM_ARCH}"

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz

sudo rm -rf /opt/nvim-linux-${NVIM_ARCH}
sudo tar -C /opt -xzf nvim-linux-${NVIM_ARCH}.tar.gz

# Add neovim to PATH in ~/.bashrc if not already present
if ! grep -q "/opt/nvim-linux-${NVIM_ARCH}/bin" ~/.bashrc; then
    echo "export PATH=\"\$PATH:/opt/nvim-linux-${NVIM_ARCH}/bin\"" >> ~/.bashrc
fi

# Add vim alias for nvim in ~/.bashrc if not already present
if ! grep -q "alias vim=nvim" ~/.bashrc; then
    echo "alias vim=nvim" >> ~/.bashrc
fi

export PATH="$PATH:/opt/nvim-linux-${NVIM_ARCH}/bin"
alias vim=nvim

git clone https://github.com/dillonalaird/dotfiles.git
mkdir -p ~/.config/
cp -r dotfiles/nvim/.config/nvim ~/.config/
cp dotfiles/tmux/.tmux.conf ~/

# Reload Supervisor
supervisorctl reload
