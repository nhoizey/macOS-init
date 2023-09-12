#!/bin/sh

## README
# /!\ This installation script is designed for my OWN use.
#     Do not run it without checking each command!

mkdir $HOME/Downloads/macOS-init
cd $HOME/Downloads/macOS-init
curl -sL https://github.com/nhoizey/macOS-init/archive/master.zip -o master.zip
unzip -qj master.zip
rm master.zip run.sh
chmod +x run-first.sh post-sync.sh
./run-first.sh
