#!/bin/sh

## README
# /!\ This installation script is designed for my OWN use.
#     Do not run it without checking each command!

echo "Restoring preferences synced with Mackup on Synology Drive"
# Default Mackup sync engine is Dropbox:
# https://github.com/lra/mackup/blob/master/doc/README.md
echo -e "[storage]\nengine = file_system\npath = Synology/Personnel" >> ~/.mackup.cfg

# Backup recovery without having to request authorisation each time
mackup restore -n

# Saving screenshots to Synology Drive
defaults write com.apple.screencapture location -string "$HOME/Synology/Personnel/Captures"

echo "dnsmasq configuration"
# http://passingcuriosity.com/2013/dnsmasq-dev-osx/
if [ ! -e "/usr/local/etc/dnsmasq.conf" ]; then
  echo 'address=/.test/127.0.0.1' >> $(brew --prefix)/etc/dnsmasq.conf
  sudo brew services start dnsmasq
fi

# Change npm's config so it uses ^ (minor versions) by default when saving dependencies
echo "npm configuration"
npm config set save-prefix '^'

echo "git configuration"
git config --global init.defaultBranch main

echo ""
echo "ET VOILÀ !"
echo "You can now activate other folders in Synology Drive synchronization."
