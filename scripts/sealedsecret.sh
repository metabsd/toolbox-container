#!/bin/bash -e
################################################################################
##  File:  sealedsecret.sh
##  Desc:  Installs the SealedSecret CLI
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the Sealed Secret
DOWNLOAD_URL="https://github.com/bitnami-labs/sealed-secrets/releases/download/v$1/kubeseal-$1-linux-amd64.tar.gz"
PACKAGE_TAR_NAME="sealedsecret.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin"