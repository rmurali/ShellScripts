#!/bin/sh
 
echo "A script that generates an asymmetric key pair, puts the private key ina  keystore and the public key in a CSR"
 
rm example.p12  2> /dev/null
rm example.csr 2> /dev/null
rm exampleKey.key 2> /dev/null
 
#
echo "Generating keys"
openssl req -out example.csr -new -newkey rsa:2048 -nodes -keyout exampleKey.key -subj "/C=AU/ST=NSW/L=Sydney/O=Example Corporation/OU=Example Technology/CN=example"
 
echo "Generating csr"
openssl req -x509 -sha256 -new -key exampleKey.key -out server.csr  -subj "/C=AU/ST=NSW/L=Sydney/O=Example Corporation/OU=Example Technology/CN=example"
 
echo "Generating .crt file"
openssl x509 -sha256 -days 3652 -in server.csr -signkey exampleKey.key -out selfsigned.crt
 
echo "generating p12"
openssl pkcs12 -export -name examplesignkey -in selfsigned.crt -inkey exampleKey.key -out example.p12
 
rm server.csr
rm *.crt
rm *.key
