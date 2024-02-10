#!/bin/bash -e
################################################################################
##  File:  go.sh
##  Desc:  Installs the GO CLI
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the GO
DOWNLOAD_URL="https://go.dev/dl/go$1.linux-amd64.tar.gz"
PACKAGE_TAR_NAME="go.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
rm -rf /usr/local/go
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local"
export PATH=$PATH:/usr/local/go/bin