#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

mkdir $HOME/Downloads/macOS-post-installation
cd $HOME/Downloads/macOS-post-installation
curl -sL https://github.com/nhoizey/macOS-post-installation/archive/master.zip
unzip -qj master.zip
rm master.zip run.sh
chmod +x post-install.sh post-cloud.sh
./post-install.sh
