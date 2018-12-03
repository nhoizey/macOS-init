#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

mkdir $HOME/Downloads/macOS-init
cd $HOME/Downloads/macOS-init
curl -sL https://github.com/nhoizey/macOS-init/archive/home.zip -o home.zip
unzip -qj home.zip
rm home.zip run.sh
chmod +x run-first.sh post-sync.sh
./run-first.sh
