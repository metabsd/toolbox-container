#!/bin/bash -e
################################################################################
##  File:  butane.sh
##  Desc:  Installs the Butane CLI
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the Butane CLI
DOWNLOAD_URL="https://mirror.openshift.com/pub/openshift-v4/clients/butane/latest/butane"
PACKAGE_NAME="butane"
download_with_retries "$DOWNLOAD_URL" "/usr/local/bin" $PACKAGE_NAME
chmod +x /usr/local/bin/butane