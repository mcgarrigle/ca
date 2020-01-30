#!/bin/bash

# usage:
# show-cert.sh <certfile>
#

CERT="$1"

openssl x509 -in "${CERT}" -text -noout
