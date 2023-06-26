#!/bin/bash

#PETSTORE_URL='http://petstore.corp.fabriclab.ca/api/v3'
PETSTORE_URL='https://petstore.buonassera.fr/api/v3'

echo "Sending GET API calls to ${PETSTORE_URL}"
echo ""

for ((i=0; i<101; i++))
do
  curl -A ML-Requester -s -o /dev/null -X 'GET' \
  "${PETSTORE_URL}/pet/findByStatus?status=available" \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  curl -A ML-Requester -s -o /dev/null -X 'GET' \
  "${PETSTORE_URL}/pet/findByStatus?status=pending" \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  curl -A ML-Requester -s -o /dev/null -X 'GET' \
  "${PETSTORE_URL}/pet/findByStatus?status=sold" \
  -H 'accept: application/json' \
  -H 'content-type: application/json'

  echo -ne "Requests sent (GET): $i\r"
done

echo ""
echo ""
echo "FortiWeb API ML trained with GET method on ${PETSTORE_URL}/"
