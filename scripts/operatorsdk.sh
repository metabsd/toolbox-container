#!/bin/bash -e
################################################################################
##  File:  operatorsdk.sh
##  Desc:  Installs the Operator SDK
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the Operator SDK
DOWNLOAD_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/operator-sdk/${1}/operator-sdk-v${2}-ocp-linux-x86_64.tar.gz"
PACKAGE_TAR_NAME="operadorsdk.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin" --strip-components 1
mv /usr/local/bin/x86_64/operator-sdk /usr/local/bin/operator-sdk
rm -rf /usr/local/bin/x86_64 && chmod +x /usr/local/bin/operator-sdk