#!/bin/bash

PETSTORE_URL='https://petstore.buonassera.fr/api/v3'
ID=420
NAMES=(FortiPuma FortiFish FortiSpider FortiTiger FortiLion FortiShark FortiSnake FortiMonkey FortiFox FortiRam FortiEagle FortiBee FortiCat FortiDog FortiAnt FortiWasp FortiPanter FortiGator FortiOwl FortiWildcats)
PETS=(Puma Fish Spider Tiger Lion Shark Snake Monkey Fox Ram Eagle Bee Cat Dog Ant Wasp Panter Gator Owl Wildcats)
STATUS=(available pending sold available pending sold available pending sold available pending sold available pending sold available pending sold available pending)

echo "Sending POST API calls to ${PETSTORE_URL} to populate pets entries with FortiPets"
echo ""

for ((i=1; i<20; i++))
do
  curl_cmd="curl -k -A ML-API-Demo-Tool -X 'POST' '${PETSTORE_URL}/pet' -H 'accept: application/xml' -H 'Content-Type: application/json' -d '{\"id\": $ID, \"category\": {\"id\": $ID, \"name\": \"${PETS[$i]}\"}, \"name\": \"${NAMES[$i]}\", \"photoUrls\": [\"Willupdatelater\"], \"tags\": [{\"id\": $ID, \"name\": \"${NAMES[$i]}\"}], \"status\": \"${STATUS[$i]}\"}'"

  echo "${i}: ${curl_cmd}"
  echo ""
  eval "${curl_cmd}"
  echo ""
  echo ""
  
  ID=$((ID+1))

  echo -ne "Requests sent (POST): $((i))\r"
done

echo ""
echo ""
echo "FortiWeb API ML trained with POST method on ${PETSTORE_URL}/"
