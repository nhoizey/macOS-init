#!/bin/sh

## README
# /!\ This installation script is designed for my OWN use.
#     Do not run it without checking each command!
#
# This additional automation directly launches the installation of
# **my own selection** of applications for **my own computer**,
# after initial connection to the Mac App Store:
#
# $ curl -sfL https://nhoizey.github.io/macOS-init/run.sh | sh

mkdir $HOME/Downloads/macOS-init
cd $HOME/Downloads/macOS-init
curl -sL https://github.com/nhoizey/macOS-init/archive/master.zip -o master.zip
unzip -qj master.zip
rm master.zip run.sh
chmod +x run-first.sh post-sync.sh
./run-first.sh
