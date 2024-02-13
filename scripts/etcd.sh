#!/bin/bash -e
################################################################################
##  File:  etcd.sh
##  Desc:  Installs the etcd CLI
################################################################################

# shellcheck source=/dev/null
source "helper/install.sh"

# Install the ETCD CLI
DOWNLOAD_URL="https://storage.googleapis.com/etcd/${1}/etcd-${1}-linux-amd64.tar.gz"
PACKAGE_TAR_NAME="etcd-linux-amd64.tar.gz"
download_with_retries "$DOWNLOAD_URL" "/tmp" $PACKAGE_TAR_NAME
tar xzf "/tmp/$PACKAGE_TAR_NAME" -C "/usr/local/bin/" --strip-components=1
rm -f /tmp/etcd-linux-amd64.tar.gz

/usr/local/bin/etcd --version
/usr/local/bin/etcdctl version
/usr/local/bin/etcdutl version
