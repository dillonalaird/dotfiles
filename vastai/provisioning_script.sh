#!/bin/bash

cd /workspace/
# Cause the script to exit on failure.
set -eo pipefail

# Activate the main virtual environment
. /venv/main/bin/activate

sudo apt update
sudo apt install neovim

git clone https://github.com/dillonalaird/dotfiles.git
mkdir -p ~/.config/
cp -r dotfiles/nvim/.config/nvim ~/.config/
cp dotfiles/tmux/.tmux.conf ~/

# Reload Supervisor
supervisorctl reload
