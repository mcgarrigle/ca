#!/bin/bash

# 1. Country Name (2 letter code) [XX]:GB
# 2. State or Province Name (full name) []:
# 3. Locality Name (eg, city) [Default City]:London
# 4. Organization Name (eg, company) [Default Company Ltd]:Company
# 5. Organizational Unit Name (eg, section) []:
# 6. Common Name (eg, your name or your server's hostname) []:ca.local
# 7. Email Address []:someone@example.com

answers() {
  echo GB
  echo "."
  echo London
  echo Company
  echo "."
  echo ca.example.com
  echo hostmaster@example.com
}

# generate key with this

# openssl genrsa -out private/cakey.key 2048

rm cacert.pem

answers | openssl req -x509 -new -nodes -key private/cakey.key -sha256 -days 3650 -out cacert.pem

openssl x509 -text -noout -in cacert.pem
