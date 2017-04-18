#!/bin/sh

## README
# /!\ Ce script de mise à jour est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

brew update
brew upgrade
brew prune

brew cask outdated --greedy --verbose | grep -v latest | cut -f1 -d" " | xargs -I % sh -c 'brew cask uninstall %; brew cask install %;'

brew cleanup -s
brew cask cleanup

brew doctor

echo ""
echo "ET VOILÀ !"
