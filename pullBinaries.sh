#!/bin/bash

source ./utils.sh

FABRIC_VERSION="2.2.1"
FABRIC_CA_VERSION="1.4.9"

ARCH="$(uname -s | tr '[:upper:]' '[:lower:]')-amd64"

infoln "Pulling fabric v${FABRIC_VERSION}"

DOWNLOAD_FABRIC_URL="https://github.com/hyperledger/fabric/releases/download/v${FABRIC_VERSION}/hyperledger-fabric-${ARCH}-${FABRIC_VERSION}.tar.gz"

set -x

curl -L "${DOWNLOAD_FABRIC_URL}" | tar xz

res=$?

{ set +x; } 2>/dev/null

if [ ${res} -ne 0 ]; then
  fatalln "Pull failed"
fi

infoln "Pulling fabric ca v${FABRIC_CA_VERSION}"

DOWNLOAD_FABRIC_CA_URL="https://github.com/hyperledger/fabric-ca/releases/download/v${FABRIC_CA_VERSION}/hyperledger-fabric-ca-${ARCH}-${FABRIC_CA_VERSION}.tar.gz"

set -x

curl -L "${DOWNLOAD_FABRIC_CA_URL}" | tar xz

res=$?

{ set +x; } 2>/dev/null

if [ ${res} -ne 0 ]; then
  fatalln "Pull failed"
fi
