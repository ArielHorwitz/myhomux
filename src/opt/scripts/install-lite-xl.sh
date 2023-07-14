#!/usr/bin/bash

DATADIR="$(pathparent $BASH_SOURCE $PWD -re)/data"
[[ ! -d $DATADIR ]] && echo "Missing data directory: $DATADIR" >&2 && exit 1

set -e

TMPDIR="/tmp/install-lite-xl/"
echo "Temporary working directory: $TMPDIR"
rm -rf $TMPDIR
mkdir -p $TMPDIR
cd $TMPDIR

# Download Lite XL v2.1.1
echo "Downloading..."
URL="https://github.com/lite-xl/lite-xl/releases/download/v2.1.1/lite-xl-v2.1.1-addons-linux-x86_64-portable.tar.gz"
echo "  $URL"
wget --no-verbose --output-document "lite-xl.tar.gz" $URL

echo "Extracting..."
tar -xzf "lite-xl.tar.gz"
cd lite-xl

echo "Copying files..."
# Copy binary
chmod +x lite-xl
mkdir -p $HOME/.local/bin
mv -f lite-xl $HOME/.local/bin/

# Copy core and addons
rm -rf $HOME/.local/share/lite-xl
mkdir -p $HOME/.local/share/lite-xl
mv -f data/* $HOME/.local/share/lite-xl/

# XDG menus
DESKTOP_APPS="$HOME/.local/share/applications/"
DESKTOP_ICONS="$HOME/.local/share/icons/hicolor/48x48/apps/"
mkdir -p $DESKTOP_APPS
mkdir -p $DESKTOP_ICONS
cp -f $DATADIR/lite-xl.desktop $DESKTOP_APPS
cp -f $DATADIR/lite-xl.png $DESKTOP_ICONS
xdg-desktop-menu forceupdate

# LSP
set +e

echo "Installing LSP..."
mkdir -p $HOME/.config/lite-xl/
cd $HOME/.config/lite-xl/
git clone https://github.com/lite-xl/lite-xl-lsp plugins/lsp
git clone https://github.com/lite-xl/lite-xl-widgets libraries/widget
git clone https://github.com/liquidev/lintplus plugins/lintplus
wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/snippets.lua -O plugins/snippets.lua
wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/lsp_snippets.lua -O plugins/lsp_snippets.lua

echo "Installing Python LSP..."
python -m pip install --break-system-packages python-lsp-server
echo "Installing bash LSP..."
npm install -g bash-language-server
echo "Installing dockerfile LSP..."
npm install -g dockerfile-language-server-nodejs


echo "Cleaning up temporary working directory $TMPDIR"
rm -rf $TMPDIR

