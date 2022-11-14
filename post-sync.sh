#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

echo "Restauration des préférences"
# Sélection du service de cloud (à décommenter si vous n'utilisez pas Dropbox, c'est le service par défaut) : https://github.com/lra/mackup/blob/master/doc/README.md
# echo -e "[storage]\nengine = google_drive" >> ~/.mackup.cfg

# Récupération de la sauvegarde sans demander à chaque fois l'autorisation
mackup restore -n

# Enregistrement des copies d'écran sur Dropbox
defaults write com.apple.screencapture location -string "$HOME/Dropbox/Captures"

echo "Configuration de dnsmasq"
# http://passingcuriosity.com/2013/dnsmasq-dev-osx/
if [ ! -e "/usr/local/etc/dnsmasq.conf" ]; then
  ln -s ~/Dropbox/Settings/dnsmasq.conf $(brew prefix)/etc/dnsmasq.conf
  sudo brew services start dnsmasq
fi

echo "Installation de oh-my-zsh"
# Installation de oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Configuration de npm"
# Change npm's config so it uses ^ (minor versions) by default when saving dependencies
npm config set save-prefix '^'

echo "Configuration de git"
git config --global init.defaultBranch main

echo ""
echo "ET VOILÀ !"
echo "Il est maintenant possible d'activer d'autres dossiers dans la synchronisation Dropbox."
