#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

# Sources :
# https://github.com/nicolinuxfr/macOS-post-installation
# https://www.macg.co/logiciels/2017/02/comment-synchroniser-les-preferences-des-apps-avec-mackup-97442
# https://github.com/OzzyCzech/dotfiles/blob/master/.osx

## QUELQUES FONCTIONS UTILES

# Installation d'apps avec Homebrew
function installWithBrew () {
  for arg in "$@"; do
    # Check if the App is already installed
    brew list | grep -i "$arg" > /dev/null
    if [ "$?" != 0 ]; then
      echo "- Installation de $arg..."
      brew install "$arg"
    fi
  done
}

# Installation d'apps avec Homebrew Cask
function installWithBrewCask () {
  for arg in "$@"; do
    # Check if the App is already installed
    brew cask list | grep -i "$arg" > /dev/null
    if [ "$?" != 0 ]; then
      echo "- Installation de $arg..."
      brew cask install "$arg"
    fi
  done
}

# Installation d'apps avec mas
# Source : https://github.com/argon/mas/issues/41#issuecomment-245846651
function installWithMAS () {
  # Check if the App is already installed
  mas list | grep -i "$1" > /dev/null
  if [ "$?" != 0 ]; then
    echo "- Installation de $1..."
    mas search "$1" | { read app_ident app_name ; mas install $app_ident ; }
  fi
}

## LA BASE : Homebrew et les lignes de commande
if test ! $(which brew)
then
  echo 'Installation de Homebrew'
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Vérifier que tout est bien à jour
brew update
brew upgrade

## Utilitaires pour les autres apps : Cask et mas (Mac App Store)
echo 'Installation de mas, pour installer les apps du Mac App Store.'
installWithBrew mas
echo "Saisir le mail du compte iTunes :"
read COMPTE
echo "Saisir le mot de passe du compte : $COMPTE"
read -s PASSWORD
mas signin $COMPTE "$PASSWORD"

echo 'Installation de Cask, pour installer les autres apps.'
brew tap caskroom/cask

## Installations des logiciels
echo 'Installation des outils système.'
installWithBrew dnsmasq

echo 'Installation des outils en ligne de commande.'
installWithBrew autojump wget ffmpeg joe youtube-dl

echo 'Installation des apps utilitaires.'
installWithBrewCask appdelete appshelf bartender carbon-copy-cloner coconutbattery controlplane crashplan disk-inventory-x dropbox duet google-drive grandperspective licecap macid qlmarkdown quicklook-csv quicklook-json rcdefaultapp rightzoom screenflow yemuzip
installWithMAS "1Password"
installWithMAS "Amphetamine"
installWithMAS "AutoMute"
installWithMAS "BetterSnapTool"
installWithMAS "Renamer"
installWithMAS "Sip"
installWithMAS "Screeny"
installWithMAS "Silent Start"
installWithMAS "Skitch"
installWithMAS "The Unarchiver"

# installation en spécifique de TigerVPN
if [ ! -e "/Applications/tigerVPN.app" ]; then
  curl -s -L -o $HOME/Downloads/tigerVPN.dmg "https://apps-tigervpn.netdna-ssl.com/mac/tigerVPN_1_1.dmg"
  hdiutil attach -quiet $HOME/Downloads/tigerVPN.dmg
  ditto -rsrc "/Volumes/tigerVPN/tigerVPN.app" /Applications/tigerVPN.app
  hdiutil detach "/Volumes/tigerVPN"
  rm -f $HOME/Downloads/tigerVPN.dmg
fi

echo "Ouverture de Dropbox pour commencer la synchronisation"
open -a Dropbox

echo 'Installation des apps de bureautique.'
installWithBrewCask macdown
installWithMAS "Evernote"
installWithMAS "ReadKit"

echo 'Installation des apps de développement.'
installWithBrewCask iterm2 ghostlab github-desktop reflector sequel-pro virtualbox virtualbox-extension-pack
# https://github.com/tonsky/FiraCode/wiki#installing-font
brew tap caskroom/fonts
installWithBrewCask font-fira-code
installWithMAS "Xcode"
installWithMAS "ForkLift"

echo 'Installation des apps de développement pour Jekyll.'
installWithBrew gsl imagemagick pkg-config
# Mise à jour de Ruby
installWithBrew ruby
# Mise à jour de RubyGems
sudo gem update --system --silent

echo 'Installation des apps de communication.'
installWithMAS "Tweetbot"
installWithMAS "Slack"
installWithMAS "Opera"
installWithBrewCask colloquy firefox google-chrome rambox skype

echo 'Installation des apps de photo, vidéo et loisirs.'
installWithBrewCask catch handbrake caskroom/versions/java6 logitech-harmony molotov spotify steam subler subsmarine transmission vlc
installWithMAS "Boxy SVG"
installWithMAS "Export for iTunes"
installWithMAS "gps4cam"
installWithMAS "GIF Brewery"
installWithMAS "iFlicks 2"
installWithMAS "I Love Stars"
# Ajout des binaires Homebrew au PATH
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc

## ************************* CONFIGURATION ********************************
echo "Configuration de quelques paramètres par défaut…"

## FINDER

# Affichage de la bibliothèque
# chflags nohidden ~/Library

# Affichage de la barre latérale
defaults write com.apple.finder ShowStatusBar -bool true

# Afficher par défaut en mode colonne
# Flwv ▸ Cover Flow View
# Nlsv ▸ List View
# clmv ▸ Column View
# icnv ▸ Icon View
defaults write com.apple.finder FXPreferredViewStyle -string “clmv”

# Afficher le chemin d'accès
defaults write com.apple.finder ShowPathbar -bool true

# Affichage de toutes les extensions
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Afficher le dossier maison par défaut
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Recherche dans le dossier en cours par défaut
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Fenêtre de sauvegarde complète par défaut
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Fenêtre d'impression complète par défaut
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Sauvegarde sur disque (et non sur iCloud) par défaut
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Coup d'œil : sélection de texte
defaults write com.apple.finder QLEnableTextSelection -bool true

# Ne pas alerter en cas de modification de l'extension d'un fichier
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Pas de création de fichiers .DS_STORE sur les disques réseau et externes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Supprimer l'alerte de quarantaine des applications
defaults write com.apple.LaunchServices LSQuarantine -bool false

## DOCK

# Taille minimum
defaults write com.apple.dock tilesize -int 32
# Agrandissement actif
defaults write com.apple.dock magnification -bool true
# Taille maximale pour l'agrandissement
defaults write com.apple.dock largesize -float 128

## MISSION CONTROL

# Pas d'organisation des bureaux en fonction des apps ouvertes
defaults write com.apple.dock mru-spaces -bool false

# Mot de passe demandé immédiatement quand l'économiseur d'écran s'active
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

## COINS ACTIFS

#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# En haut à gauche : bureau
# defaults write com.apple.dock wvous-tl-corner -int 4
# defaults write com.apple.dock wvous-tl-modifier -int 0

# En haut à droite : screensaver
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0

# En bas à gauche : fenêtres de l'application
# defaults write com.apple.dock wvous-bl-corner -int 3
# defaults write com.apple.dock wvous-bl-modifier -int 0

# En bas à droite : Mission Control
# defaults write com.apple.dock wvous-br-corner -int 2
# defaults write com.apple.dock wvous-br-modifier -int 0

## CLAVIER ET TRACKPAD

# Accès au clavier complet (tabulation dans les boîtes de dialogue)
sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Arrêt pop-up clavier façon iOS
sudo defaults write -g ApplePressAndHoldEnabled -bool false

# Répétition touches plus rapide
sudo defaults write NSGlobalDomain KeyRepeat -int 1
# Délai avant répétition des touches
sudo defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Trackpad : toucher pour cliquer
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

## APPS

# Vérifier la disponibilité de mise à jour quotidiennement
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Safari : menu développeur / URL en bas à gauche / URL complète en haut / Do Not Track / affichage barre favoris
defaults write com.apple.safari IncludeDevelopMenu -int 1
defaults write com.apple.safari ShowOverlayStatusBar -int 1
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Chrome : désactiver la navigation dans l'historique au swipe
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE

# Photos : pas d'affichage pour les iPhone
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES

# TextEdit : .txt par défaut
defaults write com.apple.TextEdit RichText -int 0

# TextEdit : ouvre et enregistre les fichiers en UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

## SONS

# Alertes sonores quand on modifie le volume
sudo defaults write com.apple.systemsound com.apple.sound.beep.volume -float 1

## IMAGES

# Enregistrer les screenshots en PNG (autres options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Ne pas mettre d'ombre sur les screenshots
defaults write com.apple.screencapture disable-shadow -bool true

## ************ Fin de l'installation *********
echo "Finder et Dock relancés… redémarrage nécessaire pour terminer."
killall Dock
killall Finder

echo "Derniers nettoyages…"
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

echo ""
echo "ET VOILÀ !"
echo "Après synchronisation des données cloud (Dropbox, Google Drive, iCloud), lancer le script post-cloud.sh"