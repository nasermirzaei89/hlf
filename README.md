# Run a network

## Pull binaries

```sh
./pullBinaries.sh
```

## Export binaries path

```sh
export PATH=$PATH:$PWD/bin
```

## Remove old data if exists

```sh
rm -rf $PWD/vol
```

## Run Orderer1 CA

```sh
unset $(env | grep FABRIC_ |awk -F'=' '{print $1}')

export FABRIC_CA_SERVER_HOME=$PWD/vol/org1/orderer1/ca
export FABRIC_CA_SERVER_CA_NAME=ca-orderer1-org1
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_SERVER_BOOT=admin:adminpw

fabric-ca-server start
```

## Enroll CA Admin

```sh
unset $(env | grep FABRIC_ |awk -F'=' '{print $1}')

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/vol/org1/orderer1/ca/tls-cert.pem
export FABRIC_CA_CLIENT_CA_NAME=ca-orderer1-org1
export FABRIC_CA_CLIENT_URL=https://admin:adminpw@localhost:7054
export FABRIC_CA_CLIENT_MSPDIR=$PWD/vol/org1/orderer1/users/admin/msp

rm -rf $FABRIC_CA_CLIENT_MSPDIR

fabric-ca-client enroll
```

## Register Orderer User

```sh
unset $(env | grep FABRIC_ |awk -F'=' '{print $1}')

export FABRIC_CA_CLIENT_MSPDIR=$PWD/vol/org1/orderer1/users/admin/msp
export FABRIC_CA_CLIENT_URL=https://localhost:7054
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/vol/org1/orderer1/ca/tls-cert.pem
export FABRIC_CA_CLIENT_CA_NAME=ca-orderer1-org1
export FABRIC_CA_CLIENT_ID_NAME=orderer
export FABRIC_CA_CLIENT_ID_SECRET=ordererpw
export FABRIC_CA_CLIENT_ID_TYPE=orderer

fabric-ca-client register

```

## Enroll Orderer User

```sh
unset $(env | grep FABRIC_ |awk -F'=' '{print $1}')

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/vol/org1/orderer1/ca/tls-cert.pem
export FABRIC_CA_CLIENT_CA_NAME=ca-orderer1-org1
export FABRIC_CA_CLIENT_URL=https://orderer:ordererpw@localhost:7054
export FABRIC_CA_CLIENT_CSR_HOSTS=localhost
export FABRIC_CA_CLIENT_MSPDIR=$PWD/vol/org1/orderer1/users/orderer/msp

rm -rf $FABRIC_CA_CLIENT_MSPDIR

fabric-ca-client enroll
```

## TLS Enroll Orderer User

```sh
unset $(env | grep FABRIC_ |awk -F'=' '{print $1}')

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/vol/org1/orderer1/ca/tls-cert.pem
export FABRIC_CA_CLIENT_CA_NAME=ca-orderer1-org1
export FABRIC_CA_CLIENT_URL=https://orderer:ordererpw@localhost:7054
export FABRIC_CA_CLIENT_CSR_HOSTS=localhost
export FABRIC_CA_CLIENT_MSPDIR=$PWD/vol/org1/orderer1/users/orderer/tls
export FABRIC_CA_CLIENT_ENROLLMENT_PROFILE=tls

rm -rf $FABRIC_CA_CLIENT_MSPDIR

fabric-ca-client enroll
```

## Run Orderer1

```sh
unset $(env | grep FABRIC_ |awk -F'=' '{print $1}')

export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_LISTENPORT=7050
export ORDERER_GENERAL_GENESISMETHOD=file
export ORDERER_GENERAL_BOOTSTRAPFILE=$PWD/vol/org1/orderer1/genesis.block
export ORDERER_GENERAL_LOCALMSPID=OrdererMSP
export ORDERER_GENERAL_LOCALMSPDIR=$PWD/vol/org1/orderer1/users/orderer/msp
export ORDERER_GENERAL_TLS_ENABLED=true
export ORDERER_GENERAL_TLS_PRIVATEKEY=$PWD/vol/org1/orderer1/users/orderer/tls/keystore/*

orderer start
```
