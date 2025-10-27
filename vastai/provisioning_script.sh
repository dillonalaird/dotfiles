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

# Reconfigure the instance portal
rm -f /etc/portal.yaml
export PORTAL_CONFIG="localhost:1111:11111:/:Instance Portal|localhost:1234:11234:/:My Application"

# Reload Supervisor
supervisorctl reload
