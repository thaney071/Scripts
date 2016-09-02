# Scripts
Helper scripts to automate tasks

## Atom Installer Linux
This script is used as an installer for Atom text editor.

1. Download the latest Atom deb from the Atom web page.
2. dpkg the downloaded deb
3. Use apm to install additional Atom packages from atom-package-list.txt
4. Make a backup of the config.cson file
5. Place a new config.cson file.

For now, to change the additional Atom packages, you can replace the
atom-package-list.txt file with your own list of atom packages.

If you want to return to the Default atom config, replace the config.cson file
with the config-default.cson. The config-default.cson is the original Atom
settings.
