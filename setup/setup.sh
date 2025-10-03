#!/bin/bash
set -e
curl -LsSf https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -sS https://starship.rs/install.sh | sh
curl https://install.duckdb.org | sh
brew install --cask font-jetbrains-mono-nerd-font
brew install visual-studio-code

