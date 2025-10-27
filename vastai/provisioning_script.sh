#!/bin/bash

cd /workspace/
# Cause the script to exit on failure.
set -eo pipefail

# Activate the main virtual environment
. /venv/main/bin/activate

git clone https://github.com/dillonalaird/dotfiles.git
mkdir -p ~/.config/
cp -r dotfiles/.config/nvim ~/.config/nvim
cp dotfiles/.tmux.conf ~/.tmux.conf

# Reload Supervisor
supervisorctl reload
