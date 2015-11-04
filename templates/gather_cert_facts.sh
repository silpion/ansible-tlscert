#!/bin/bash

set -euo pipefail

CERTPATH=${1:-{{ssl_roleinternal_crt_path}}}
KEYPATH=${2:-{{ssl_roleinternal_key_path}}}

# Get all valid PEM certificates
CERTS=$(find $CERTPATH |xargs file |grep "PEM certificate$" |grep -v 'ca-certificates.crt' |cut -d: -f1)

# Get all certificate keys
KEYS=$(find $KEYPATH |xargs file|grep 'ASCII text'|cut -d: -f1)

# Start cert dict
echo '---'
echo 'certs:'

# Iterate through the certs
for cert in $CERTS; do

        # Get the CN and if existant all subject alternate names
        DOMAINS=$(openssl x509 -in $cert  -noout -text|egrep 'Subject.*CN.*|DNS'|tr -d '\n| |,'|awk -F"CN=|DNS:" '{$1=""; print $0}'|sed 's/\/emailAddress=.*//'|tr ' ' '\n'|uniq)

        # Get the matching key
        CERTMODULUS=$(openssl x509 -noout -modulus -in $cert)
        KEY=""
        for file in $KEYS; do
                if [[ $CERTMODULUS == $(openssl rsa -noout -modulus -in $file) ]]; then
                        KEY=$file
                        break
                fi
        done

        # Generate a yaml dict entry for each domain
        for domain in $DOMAINS; do
                echo "  $domain:"
                echo "    crt: $cert"
                echo "    key: $KEY"
        done

done
