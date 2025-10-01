#!/bin/bash
set -e
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl -sS https://starship.rs/install.sh | sh
brew install --cask font-jetbrains-mono-nerd-font
brew install visual-studio-code

