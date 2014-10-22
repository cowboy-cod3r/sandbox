#!/bin/bash

echo "INFO: Creates a certification authority"

echo "INFO: Create the private root key. Keep this private"
# If you want to password protect it, do this:
# openssl genrsa -out ca.key 2048 -des3
openssl genrsa -out ca.key 2048

echo "INFO: Self sign the key"
openssl req -x509 -new -nodes -key ca.key -days 1024 -out ca.pem
