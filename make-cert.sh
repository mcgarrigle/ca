#!/bin/bash

# make-cert.sh
#
# usage:
# make-cert.sh <fqdn>
#

SUBJECT="$1"

CONFIG="${SUBJECT}.conf"
KEY="${SUBJECT}.key"

cat > "${CONFIG}" <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[dn]
C = GB
L = London
O = Company
CN = ${SUBJECT}
EOF

# ------------------------------------------

generate-key() {
  if [ ! -f "${KEY}" ]; then
    openssl genrsa -out "${KEY}" 4096
  fi
}

# ------------------------------------------
# generate CSR from config

generate-csr() {
  openssl req -new -sha256 \
    -key "${KEY}" \
    -nodes \
    -config "${CONFIG}" \
    -out "${SUBJECT}.csr"

  # openssl req -in "${SUBJECT}.csr" -noout -text
}

# ------------------------------------------
# generate CERT from CSR

generate-cert() {
  openssl x509 -req \
    -in "${SUBJECT}.csr" \
    -out "${SUBJECT}.crt" \
    -CA "cacert.pem" \
    -CAkey "private/cakey.key" \
    -CAcreateserial \
    -days 3650 \
    -sha256

  # openssl x509 -in "${SUBJECT}.crt" -text -noout
}

# ------------------------------------------

generate-key
generate-csr
generate-cert
