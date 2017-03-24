#!/bin/sh

## README
# /!\ Ce script de mise à jour est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

brew update
brew upgrade

brew cleanup -s
brew cask cleanup

echo ""
echo "ET VOILÀ !"
