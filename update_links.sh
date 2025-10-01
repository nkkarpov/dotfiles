#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$DOTFILES_DIR/dotfiles.conf"

echo "Installing dotfiles from $DOTFILES_DIR"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found at $CONFIG_FILE"
    exit 1
fi

while IFS=: read -r source target || [ -n "$source" ]; do
    # Skip comments and empty lines
    [[ "$source" =~ ^#.*$ ]] && continue
    [[ -z "$source" ]] && continue

    # Expand tilde in target path
    target="${target/#\~/$HOME}"

    # Remove leading/trailing whitespace
    source=$(echo "$source" | xargs)
    target=$(echo "$target" | xargs)

    source_path="$DOTFILES_DIR/$source"

    if [ ! -e "$source_path" ]; then
        echo "Warning: Source file not found: $source_path"
        continue
    fi

    # Create target directory if it doesn't exist
    target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        echo "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi

    # Check if target already exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            existing_link=$(readlink "$target")
            if [ "$existing_link" = "$source_path" ]; then
                echo "Already linked: $source -> $target"
                continue
            else
                echo "Removing existing symlink: $target -> $existing_link"
                rm "$target"
            fi
        else
            echo "Backing up existing file: $target -> $target.backup"
            mv "$target" "$target.backup"
        fi
    fi

    echo "Linking: $source -> $target"
    ln -s "$source_path" "$target"

done < "$CONFIG_FILE"

echo "Done!"
