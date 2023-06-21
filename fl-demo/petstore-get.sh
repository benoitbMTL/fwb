#!/bin/bash

echo "Sending GET API calls to http://petstore.corp.fabriclab.ca"
echo ""

for ((i=0; i<101; i++))
do
  curl -A ML-Requester -s -o /dev/null -X 'GET' \
  'http://petstore.corp.fabriclab.ca/api/v3/pet/findByStatus?status=available' \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  curl -A ML-Requester -s -o /dev/null -X 'GET' \
  'http://petstore.corp.fabriclab.ca/api/v3/pet/findByStatus?status=pending' \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  curl -A ML-Requester -s -o /dev/null -X 'GET' \
  'http://petstore.corp.fabriclab.ca/api/v3/pet/findByStatus?status=sold' \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  echo -ne "Requests sent (GET): $i\r"
done

echo ""
echo ""
echo "FortiWeb API ML trained with GET method on http://petstore.corp.fabriclab.ca/"
