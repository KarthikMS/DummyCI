#!/bin/sh

if [ "$PROFILE_DECRYPTION_KEY" == "superSecretPassPhrase1" ]
then
  echo "Prov pass Correct"
else 
  echo "Prov pass NOT correct"
fi