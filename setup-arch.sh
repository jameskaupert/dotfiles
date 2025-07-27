#!/bin/bash
set -e

echo "🚀 Setting up Arch development environment..."

# System packages
echo "📦 Installing system packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel git curl wget unzip docker docker-compose

# Docker setup
echo "🐳 Setting up Docker..."
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# AUR helper
echo "📦 Installing AUR helper..."
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Chezmoi
echo "🏠 Setting up chezmoi..."
sudo pacman -S --noconfirm chezmoi
if [ ! -z "$DOTFILES_REPO" ]; then
    chezmoi init --apply $DOTFILES_REPO
fi

# Mise
echo "🔧 Installing mise..."
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

