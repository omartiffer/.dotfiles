# Dotfiles

<!--toc:start-->
- [Dotfiles](#dotfiles)
  - [✨ What’s in here?](#✨-whats-in-here)
  - [📂 Project structure](#📂-project-structure)
  - [👨‍💻 Getting started (at your own risk)](#👨‍💻-getting-started-at-your-own-risk)
    - [1. Clone the repo](#1-clone-the-repo)
    - [2. Change into the cloned .dotfiles directory](#2-change-into-the-cloned-dotfiles-directory)
    - [3. Set the `DOTFILES` environment variable to the absolute path of the cloned repo](#3-set-the-dotfiles-environment-variable-to-the-absolute-path-of-the-cloned-repo)
    - [4. Run the installation script](#4-run-the-installation-script)
    - [5. Run the configuration script](#5-run-the-configuration-script)
    - [6. Test before running (dry mode)](#6-test-before-running-dry-mode)
    - [7. Load GNOME config (optional)](#7-load-gnome-config-optional)
  - [🤝 Attributions](#🤝-attributions)
<!--toc:end-->

[![License](https://img.shields.io/github/license/oatiffer/.dotfiles)](/LICENSE)

> **"This was supposed to be fun!"**  
> Me, 3 hours into trying to be _dotfiles_-cool.

My attempt to shellscript my way through automating the setup of my next shiny computer. This is an evolving collection of config files, setup scripts, and personal preferences designed as a full environment bootstrapper.

I follow [@ThePrimeagen's](https://github.com/ThePrimeagen) premise of convention over configuration (see [Attributions](#-attributions) below). Whenever I need to change a config, I edit the files in the repo and run [`config.sh`](/config.sh). I might switch approaches later, but this works well for now.

<https://github.com/user-attachments/assets/60a63788-a49b-4a3b-82f4-b35eac8d307e>

## ✨ What’s in here?

- ⚙️ Config files for the tools I use
- 🚀 Install scripts for those tools
- 🚰 Script to hydrate (copy) config files
- 🛠️ Utils script for common operations
- 🧪 A whole lot of trial and error

I'll keep adding things as the need arises.

## 📂 Project structure

```text
/
├── .config/                # Configuration files for most tools (copied to ~/.config)
├── .local/
│   └── my-scripts/         # Tmux sessionizer scripts (copied to ~/.local/my-scripts)
├── gnome-files/            # GNOME's config files
├── installs/               # Installation scripts for all tools
├── .gitconfig              # My global git config file (copied to ~/.gitconfig)
├── .tmux.conf              # My Tmux config file (copied to ~/.tmux.conf)
├── .zshrc                  # Zsh config file (copied to ~/.zshrc)
├── LICENSE                 # License file (see the attributions section)
├── config.sh               # Copies all config files and sessionizer scripts to ~/
├── gnome.sh                # Copies wallpapers and hydrates GNOME's dconf
├── install.sh              # Runs all scripts in the installs/ directory
└── utils.sh                # Functions used across all scripts
```

## 👨‍💻 Getting started (at your own risk)

**IMPORTANT:** These files are tailored for my machine, OS, and habits — feel free to use/fork **(at your own risk)**, suggest changes, or just laugh at my choices.

Tested on:

![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04.2%20LTS-ef5b24?logo=ubuntu&style=for-the-badge)
![GNOME](https://img.shields.io/badge/Desktop-GNOME%2046-4a86cf?logo=gnome&style=for-the-badge)

### 1. Clone the repo

```bash
git clone https://github.com/oatiffer/.dotfiles.git
```

### 2. Change into the cloned .dotfiles directory

```bash
cd .dotfiles
```

### 3. Set the `DOTFILES` environment variable to the absolute path of the cloned repo

```bash
export DOTFILES=cloned_repo_directory_path
```

For example, if you cloned the repo to `~/workspace/.dotfiles`, then:

```bash
export DOTFILES=$HOME/workspace/.dotfiles
```

**IMPORTANT:** The scripts won't run if you omit this step.

### 4. Run the installation script

```bash
./install.sh
```

This script runs all available scripts in the [`installs/`](/installs/) directory. You can run a specific install script by passing a name to [`install.sh`](/install.sh) as an argument. For example:

```bash
./install.sh docker
```

Will only run the docker installation script and skip the rest.

### 5. Run the configuration script

```bash
./config.sh
```

This script copies all configuration files to their expected locations under `~/` and places the tmux sessionizer scripts in `~/.local/my-scripts`.

### 6. Test before running (dry mode)

```bash
./install.sh --dry-run
```

or

```bash
./config.sh --dry-run
```

### 7. Load GNOME config (optional)

Use the GNOME extension manager to install the following extensions:

- Just Perfection
- Space Bar
- Switcher

Then run the [`gnome.sh`](/gnome.sh) script:

```bash
./gnome.sh
```

This script copies all desktop backgrounds in [`gnome-files/backgrounds/`](/gnome-files/backgrounds/) to `~/.local/share/backgrounds/` and loads [`gnome.dconf`](/gnome-files/gnome.dconf) to apply GNOME + extensions settings.

## 🤝 Attributions

- [@dwt1](https://gitlab.com/dwt1) – I learned a lot from him when I was considering using a bare repo for my dotfiles.
- [@ThePrimeagen](https://github.com/ThePrimeagen) – I studied the scripts in his dotfiles repo line by line. Portions of this project are based on code from his [My Dev Setup Is Better Than Yours](https://frontendmasters.com/courses/developer-productivity-v2/) course on [Frontend Masters](https://frontendmasters.com/). The original code is licensed under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) and modifications may have been made.

**NOTE:** I used these repos and course to learn the concepts, syntax, and pick up ideas. Most of the code you'll find here is still my own (and ChatGPT's).
