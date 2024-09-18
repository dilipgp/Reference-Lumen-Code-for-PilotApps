#!/bin/bash

 

eval "$(jq -r '@sh "secret=\(.secret) pem_public_key=\(.pem_public_key)"')"

 

result=$( openssl rsautl -encrypt \
  -pubin -inkey <( echo '-----BEGIN PUBLIC KEY-----' ; echo ${pem_public_key} ; echo '-----END PUBLIC KEY-----' ) \
  -ssl -in <(echo ${secret}) | base64 -w 0 )

 

cat <<EOM
{
  "result": "${result}"
}
EOM