#!/bin/bash -e
################################################################################
##  File:  oc.sh
##  Desc:  Installs the OC CLI
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the oc CLI
DOWNLOAD_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest-$1/openshift-client-linux.tar.gz"
PACKAGE_TAR_NAME="oc.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin/"