#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

mkdir $HOME/Downloads/macOS-init
cd $HOME/Downloads/macOS-init
curl -sL https://github.com/nhoizey/macOS-init/archive/master.zip
unzip -qj master.zip
rm master.zip run.sh
chmod +x post-install.sh post-cloud.sh
./post-install.sh
