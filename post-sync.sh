#!/bin/sh

## README
# /!\ This installation script is designed for my OWN use.
#     Do not run it without checking each command!

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
