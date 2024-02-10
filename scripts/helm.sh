#!/bin/bash -e
################################################################################
##  File:  helm.sh
##  Desc:  Installs the Helm CLI
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the Helm CLI
DOWNLOAD_URL="https://get.helm.sh/helm-v$1-linux-amd64.tar.gz"
PACKAGE_TAR_NAME="helm.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin" --strip-components 1