# Dotfiles

Personal configuration files managed through symbolic links.

## Quick Start

Install dotfiles:
```bash
./update_links.sh
```

## What's Included

- VSCode settings and keybindings

## How It Works

The `dotfiles.conf` file maps source files in this repository to target locations on your system. Running `update_links.sh` creates symbolic links from the repository to those locations.

## Adding New Dotfiles

1. Add your configuration file to the repository
2. Add a mapping to `dotfiles.conf`:
   ```
   path/in/repo:~/target/location
   ```
3. Run `./update_links.sh`

The script will:
- Create target directories if needed
- Back up existing files (as `*.backup`)
- Create symbolic links
- Skip files that are already correctly linked
