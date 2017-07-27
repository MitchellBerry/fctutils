#!/usr/bin/env bash
cd $HOME
apt update
apt upgrade
wget https://github.com/FactomProject/distribution/releases/download/v0.4.2.4/factom-amd64.deb
dpkg -i --force-architecture factom-amd64.deb
rm -f factom-amd64.deb
apt install unzip
wget https://www.factom.com/assets/site/factom_bootstrap.zip
unzip factom_bootstrap.zip
rm -f factom_bootstrap.zip
# boots factomd, wallet won't start by default
factomd &
sleep 5
# fctwallet
