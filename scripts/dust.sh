#!/bin/bash -e
################################################################################
##  File:  dust.sh
##  Desc:  Installs the DUST Tool ( DU ++ :) )
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the DUST
DOWNLOAD_URL="https://github.com/bootandy/dust/releases/download/${1}/dust-${1}-x86_64-unknown-linux-gnu.tar.gz"
PACKAGE_TAR_NAME="dust.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin/" --strip-components=1
rm -f /tmp/dust.tar.gz


