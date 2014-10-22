#!/bin/bash

echo "INFO: Create a private key and CSR"
openssl req -out server-csr.pem -new -newkey rsa:2048 -nodes -keyout server-key.pem
