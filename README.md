# macOS init

[![GitHub stars](https://img.shields.io/github/stars/nhoizey/macOS-init.svg?style=for-the-badge&logo=github)](https://github.com/nhoizey/macOS-init/stargazers)
[![Follow @nhoizey@mamot.fr](https://img.shields.io/mastodon/follow/000262395?domain=https%3A%2F%2Fmamot.fr&style=for-the-badge&logo=mastodon&logoColor=white&color=6364FF)](https://mamot.fr/@nhoizey)

This set of scripts automate the installation of applications and synchronization of settings, on a freshly installed macOS.

> [WARNING]
> This script was designed for **my own specific needs**.
> Before using it, remember to modify it to suit your needs!

## Usage

### Initial installation of a pristine OS

1. Install macOS
1. Run Mac App Store and log in to your account

### First step

1. Download the latest version: [main.zip](https://github.com/nhoizey/macOS-init/archive/main.zip)
1. Open the `run.sh` and `Brewfile` files, and change what is installed by default
1. Starting from the line `# Configuration` in the `run.sh` file, the script configures a number of default settings, which you can modify as required
1. Then [open macOS terminal](https://www.wikihow.tech/Use-Terminal-on-Mac#Opening-Terminal), drag and drop the `run.sh` file from the Finder to the Terminal, press the <kbd>Enter</kbd> key, and fasten your seatbelt… 😁

The script will largely work without your intervention, except :

- to validate the installation of Homebrew
- to enter the administrator password for Homebrew
- for the administrator password needed for Cask
- for certain software that requires admin access

If all goes well, it will finish normally without error, but if there is an error, you can restart the script and only what has not already been installed will be installed;

There's no second step. That's it, you're ready to start using your new computer.

### Later updates

1. Run the `update.sh` script to update any applications that require it.
