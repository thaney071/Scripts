# @File: Atom-Install-Linux.sh
# @Author: Thomas Haney
# @Date:   2016-09-02T09:31:21-07:00
# @Email:  thaney071@gmail.com
# @Last modified by:   Thomas Haney
# @Last modified time: 2016-09-02T10:31:08-07:00
# @Description: An installer for Atom text editor on Linux.

#!/bin/bash

Define variables:
txtund=$(tput sgr 0 1)    # Underline
txtbld=$(tput bold)       # Bold
txtred=$(tput setaf 1)    # Red
txtgrn=$(tput setaf 2)    # Green
txtylw=$(tput setaf 3)    # Yellow
txtblu=$(tput setaf 4)    # Blue
txtpur=$(tput setaf 5)    # Purple
txtcyn=$(tput setaf 6)    # Cyan
txtwht=$(tput setaf 7)    # White
txtrst=$(tput sgr0)       # Text reset

format="\n%-10s ${txtbld}%-30s ${txtrst} %10s\n\n"
f_done="${txtgrn}%20s${txtrst}\n"
f_error="${txtred}%20s${txtrst}\n"
f_stop="${txtred}%s${txtrst}\n"
work="\n${txtylw}%-40s${txtrst}"
clear

# If  su, this script will rerror and exit
if [ "$(id -u)" == '0' ] ; then
   printf "$f_error" "Atom-Install must be run as local user (run again without sudo)"
   exit $?
fi
printf "$format" "----" "Downloading Atom deb package" "----"

sudo wget -q https://github.com/atom/atom/releases/latest -O /tmp/latest
sudo wget --progress=bar -q 'https://github.com'$(cat /tmp/latest | grep -o -E 'href="([^"#]+)atom-amd64.deb"' | cut -d'"' -f2 | sort | uniq) -O /tmp/atom-amd64.deb -q --show-progress

printf "$format" "----" "Installing Atom" "----"
sudo dpkg -i /tmp/atom-amd64.deb

printf "$format" "----" "Intalling Additonal Atom Packages" "----"

sudo apm install --packages-file atom-package-list.txt

printf "$format" "----" "Setting Atom Config" "----"

printf "$work" "Atom Config:"
mv ~/.atom/config.cson ~/.atom/config-default.cson
cp -p config.cson ~/.atom
if [[ $? -ne 0 ]]; then
  printf "$f_error" "Failed - Error placeing config"
  printf "$f_stop" "Stopping"
  exit 1
else
  printf "$f_done" "DONE"
fi

