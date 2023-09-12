#!/bin/sh

## README
# /!\ This installation script is designed for my OWN use.
#     Do not run it without checking each command!
#
# This additional automation directly launches the installation of
# **my own selection** of applications for **my own computer**,
# after initial connection to the Mac App Store:
#
# $ curl -sfL https://nhoizey.github.io/macOS-init/for-nhoizey.sh | sh

mkdir $HOME/Downloads/macOS-init
cd $HOME/Downloads/macOS-init
curl -sL https://github.com/nhoizey/macOS-init/archive/main.zip -o main.zip
unzip -qj main.zip
rm main.zip for-nhoizey.sh
chmod +x run-first.sh post-sync.sh
./run-first.sh
