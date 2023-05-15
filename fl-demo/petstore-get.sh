# Curl commands to create API Protection Model
# FWB V7.0.1 written by Roy Scotford
#!/bin/bash

echo "Sending GET API calls to https://petstore.corp.fabriclab.ca"

for ((i=1; i<100; i++))
do
  curl -k -A ML-Requester -s -o /dev/null -X 'GET' \
  'https://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=available' \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  curl -k -A ML-Requester -s -o /dev/null -X 'GET' \
  'https://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=pending' \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  curl -k -A ML-Requester -s -o /dev/null -X 'GET' \
  'https://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=sold' \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  echo -n "."
  [[ $i == *"0" ]] && echo -n $i
done

echo ""
echo "FortiWeb API ML trained with GET method on https://petstore.corp.fabriclab.ca/"
