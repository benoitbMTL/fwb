#!/bin/bash

NAMES=(FortiPuma FortiFish FortiSpider FortiTiger FortiLion FortiShark FortiSnake FortiMonkey FortiFox FortiRam FortiEagle FortiBee FortiCat FortiDog FortiAnt FortiWasp FortiPanter FortiGator FortiOwl FortiWildcats)
PETS=(Puma Fish Spider Tiger Lion Shark Snake Monkey Fox Ram Eagle Bee Cat Dog Ant Wasp Panter Gator Owl Wildcats)
STATUS=(available pending sold available pending sold available pending sold available pending sold available pending sold available pending sold available pending)

ID=400

echo "Sending POST API calls to http://petstore.corp.fabriclab.ca/ to populate pets entries with FortiPets"

for ((i=0; i<20; i++))
do
  curl -A ML-Requester -s -o /dev/null -X 'POST' \
    'http://petstore.corp.fabriclab.ca/api/v3/pet' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
  -d "{\
    \"id\": $ID,\
    \"category\": {\
      \"id\": $ID,\
      \"name\": \"${PETS[$i]}\"\
    },\
    \"name\": \"${NAMES[$i]}\",\
    \"photoUrls\": [\
      \"Willupdatelater\"\
    ],\
    \"tags\": [\
      {\
        \"id\": $ID,\
        \"name\": \"${NAMES[$i]}\"\
      }\
    ],\
    \"status\": \"${STATUS[$i]}\"\
    }"

  ID=$((ID+1))

  echo -n "."
  [[ $i == *"0" ]] && echo -n $i
done

echo ""
