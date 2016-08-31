#!/bin/bash

clear

# If  su, this script will rerror and exit
if [ "$(id -u)" == '0' ] ; then
   printf "%s\n" "Atom-Install must be run as local user (run again without sudo)"
   exit $?
fi

sudo wget -q https://github.com/atom/atom/releases/latest -O /tmp/latest
sudo wget --progress=bar -q 'https://github.com'$(cat /tmp/latest | grep -o -E 'href="([^"#]+)atom-amd64.deb"' | cut -d'"' -f2 | sort | uniq) -O /tmp/atom-amd64.deb -q --show-progress
sudo dpkg -i /tmp/atom-amd64.deb

printf "\n----Intalling Additonal Atom Packages----\n\n"
apm install --packages-files atom-package-list.txt

chown -Rv  $USER.$USER  ~/.atom