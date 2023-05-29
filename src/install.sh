#!/bin/bash

set -e


[[ $EUID -eq 0 ]] && echo "Do not run $0 as root." && exit 1


title () { printf "\n░▒▓█ $1 \n" ; }
subtitle () { printf "\n■► $1\n" ; }
recreatedir () {
    [[ -d $1 ]] && sudo rm -rf $1
    sudo mkdir --parents $1
}

title "Installing iukbtw"

OPTDIR=/opt/iukbtw
BINDIR=/opt/iukbtw/bin
USRBINDIR=/usr/bin/iukbtw
CONFDIR=/etc/opt/iukbtw
recreatedir $BINDIR
recreatedir $USRBINDIR
recreatedir $CONFDIR

# Copy opt
sudo cp --recursive ./opt/* $OPTDIR
sudo chmod +x --recursive $BINDIR
# Remove .sh extension and symlink bin dir
for filename in "$BINDIR"/* ; do
    newname=$(echo $filename | rev | cut -d. -f2- | rev)
    sudo mv $filename $newname
    sudo cp -s $newname $USRBINDIR
done
# Add bin dir to PATH
USRPROF=$HOME/.profile
if [[ -f $USRPROF ]]; then
    # Remove export line if exists, for idempotency
    PROFILE_LINE=$(cat $USRPROF | grep -nm 1 "iuk" | cut -d: -f1)
    [[ -n $PROFILE_LINE ]] && sed -i $PROFILE_LINE"d" $USRPROF
fi
printf "export PATH=$BINDIR:\$PATH  # Add iukbtw commands to PATH\n" >> $USRPROF
# Copy config
sudo cp --recursive ./config/* $CONFDIR


# Install dependencies
if [[ $1 != "nodeps" ]]; then
    # Install packages
    subtitle "Installing dependencies"
    yay -S --needed --noconfirm - < ./deps.txt
    # Install Python libraries
    subtitle "Installing Python libraries"
    python -m pip install arrow
    python -m pip install requests
fi


# Configure
subtitle "Configuring for $USER @ $HOME"
# Add sudoer rule for /opt/iukbtw -- check with visudo before copy!
sudo groupadd -f iukbtw && sudo usermod -aG iukbtw $USER
if [[ $(visudo -csf ./sudoers | grep "parsed OK") = "" ]] ; then
    echo "Failed check on sudoer file"
    exit 1
else
    sudo cp --force ./sudoers /etc/sudoers.d/50-iukbtw
fi
# Add udev rules for KMonad
# (https://github.com/kmonad/kmonad/issues/160#issuecomment-766121884)
sudo groupadd -f uinput && sudo usermod -aG uinput $USER
sudo usermod -aG input $USER
echo uinput | sudo tee /etc/modules-load.d/uinput.conf
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/90-uinput.rules


# Copy dotfiles
subtitle "Copying user home skeleton"
cd ./skel && cp --recursive --parents ./ $HOME && cd ..


# Completion tasks
subtitle "Done."
[[
    -z $(groups | grep input) ||
    -z $(groups | grep uinput) ||
    -z $(groups | grep iukbtw)
]] && echo "Please login again for group config to apply."
[[ -z $(echo $PATH | grep $USRBINDIR) ]] && echo "Please login again for PATH to apply"
