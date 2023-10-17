#!/bin/sh
#
# Install nix and bootstap system configuration. This script is supposed to be
# executed on a fresh NixOS install:
# https://nixos.org/manual/nixos/stable/#sec-obtaining
#

DOTFILES_DIR="$HOME/.yadr"

# Install nix
# https://nix.dev/tutorials/install-nix
if ! which nix >/dev/null; then
    echo "Installing nix"
    curl -L https://nixos.org/nix/install | sh -s -- --daemon
fi

if ! nix --version >/dev/null; then
    echo "Check your nix installation"
    exit 1
fi

# Don't set -e earlier so nix is conditionally installed
set -e

# Download configuration files 
if [ ! -d "$DOTFILES_DIR" ]; then
    if ! nix-shell -p git --command "git clone https://github.com/toffernator/yadr ${DOTFILES_DIR}" >/dev/null; then
        echo "There was a git error when cloning the dotfiles repository"
        exit 1
    fi
else
    echo "'${DOTFILES_DIR}' already exists, assuming that it contains the dotfiles"
fi

# Switch to config
echo Switching configs
sudo nixos-rebuild switch --flake "${DOTFILES_DIR}/.#laptop"
echo "For group membership changes to take effect it might require a reboot"
