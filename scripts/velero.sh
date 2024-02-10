#!/bin/bash -e
################################################################################
##  File:  velero.sh
##  Desc:  Installs the Velero CLI
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the Velero CLI
DOWNLOAD_URL="https://github.com/vmware-tanzu/velero/releases/download/v$1/velero-v$1-linux-amd64.tar.gz"
PACKAGE_TAR_NAME="velero.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin" --strip-components 1