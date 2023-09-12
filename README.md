# macOS init

> **Warning**
> This script was designed for **my own specific needs**.
> Before using it, remember to modify it to suit your needs!

## Presentation

> **Note**
> I wrote a blog post, in French, about this tool: [Automatiser l'installation des applications sur un nouveau Mac](https://nicolas-hoizey.com/2017/05/automatiser-l-installation-des-applications-sur-un-nouveau-mac.html).

## Usage

### Initial installation of a pristine OS

1. Install macOS
1. Run Mac App Store and log in to your account

> **Warning**
> Please note that if you are migrating from another machine or doing a complete reinstall, use the same _username_ as much as possible, otherwise Mackup won't be able to recover application settings.

### First step

1. Download the latest version: [master.zip](https://github.com/nhoizey/macOS-init/archive/master.zip)
1. Open the `run-first.sh` and `Brewfile` files, and change what is installed by default
1. Change the `brew install synology-drive` and `open -a Synology Drive Client` lines in [`post-install.sh`](https://github.com/nhoizey/macOS-init/blob/master/post-install.sh) depending on the Cloud service you are using for settings synchronization
1. Starting from the line `# Configuration` in the `run-first.sh` file, the script configures a number of default settings, which you can modify as required
1. Then [open macOS terminal](https://www.wikihow.tech/Use-Terminal-on-Mac#Opening-Terminal), drag and drop the `run-first.sh` file from the Finder to the Terminal, press the <kbd>Enter</kbd> key, and fasten your seatbelt… 😁

The script will largely work without your intervention, except :

- to validate the installation of Homebrew
- to enter the administrator password for Homebrew
- for the administrator password needed for Cask
- for certain software that requires admin access

If all goes well, it will finish normally without error, but if there is an error, you can restart the script and only what has not already been installed will be installed;

### Second step

When the first script run is complete, and your data is synchronized from the cloud:

1. Open the `post-sync.sh` file and modify the begining according to the Cloud service you have chosen, or comment it if you are using Dropbox (the default choice for Mackup)
1. Drag and drop the `post-sync.sh` file from the Finder to the Terminal, and press the <kbd>Enter</kbd> key to finish installation.

That's it, you're ready to start using your new computer.

### Later updates

1. Run the `update.sh` script to update any applications that require it.
