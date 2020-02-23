#!/bin/bash

config() {
cat <<EOF
[req]
distinguished_name = dn
default_bits = 2048
default_md = sha256
prompt = no
[dn]
$(cat dn.conf)
CN = ROOTCA
EOF
}

config > /tmp/ca.cnf

mkdir -p private
openssl genrsa -out private/cakey.key 2048

rm -f cacert.pem
openssl req -x509 -new -nodes -config /tmp/ca.cnf -key private/cakey.key -sha256 -days 3650 -out cacert.pem

openssl x509 -text -noout -in cacert.pem
