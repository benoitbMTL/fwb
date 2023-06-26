#!/bin/bash

PETSTORE_URL='https://petstore.buonassera.fr/api/v3'
#PETSTORE_URL='http://petstore.corp.fabriclab.ca/api/v3'
USER_AGENT="ML-API-Demo-Tool"

verbose=false

if [ "$1" == "-v" ] || [ "$1" == "--verbose" ]; then
  verbose=true
fi

# Generator function for random values
generate_random_value() {
  local array=("$@")
  local length=${#array[@]}
  local random_index=$((RANDOM % length))
  echo "${array[random_index]}"
}

echo "Sending POST API calls to ${PETSTORE_URL} to populate pets entries with FortiPets"
echo ""

for ((i=1; i<=500; i++))
do
  # Generate random values for NAMES, PETS, STATUS, and IPs
  RANDOM_NAME=$(generate_random_value "FortiPuma" "FortiFish" "FortiSpider" "FortiTiger" "FortiLion" "FortiShark" "FortiSnake" "FortiMonkey" "FortiFox" "FortiRam" "FortiEagle" "FortiBee" "FortiCat" "FortiDog" "FortiAnt" "FortiWasp" "FortiPanter" "FortiGator" "FortiOwl" "FortiWildcats")
  RANDOM_PET=$(generate_random_value "Puma" "Fish" "Spider" "Tiger" "Lion" "Shark" "Snake" "Monkey" "Fox" "Ram" "Eagle" "Bee" "Cat" "Dog" "Ant" "Wasp" "Panter" "Gator" "Owl" "Wildcats")
  RANDOM_STATUS=$(generate_random_value "available" "pending" "sold")
  RANDOM_IP=$(shuf -i 0-255 -n 4 | paste -sd '.')
  RANDOM_ID=$(shuf -i 1-999 -n 1)
  
  curl_common="--insecure --user-agent '${USER_AGENT}' --request 'POST' '${PETSTORE_URL}/pet' -H 'accept: application/json' -H 'Content-Type: application/xml' -H 'X-Forwarded-For: ${RANDOM_IP}' -d '{\"id\": $RANDOM_ID, \"category\": {\"id\": $RANDOM_ID, \"name\": \"${RANDOM_PET}\"}, \"name\": \"${RANDOM_NAME}\", \"photoUrls\": [\"http://surl.li/imgkr\"], \"tags\": [{\"id\": $RANDOM_ID, \"name\": \"${RANDOM_NAME}\"}], \"status\": \"${RANDOM_STATUS}\"}'"

  if $verbose; then
    curl_cmd="curl ${curl_common}"
    echo "${i}: ${curl_cmd}"
    echo -ne "\033[32mResult:\033[0m "
    eval "${curl_cmd}"
    echo ""
    echo ""
  else
    curl_cmd="curl -s -o /dev/null ${curl_common}"
    eval "${curl_cmd}"
    echo -ne "Requests sent (POST): $((i))\r"
  fi

  curl_common="--insecure --user-agent '${USER_AGENT}' --request 'GET' '${PETSTORE_URL}/pet/findByStatus?status=${RANDOM_STATUS}' -H 'accept: application/xml' -H 'Content-Type: application/json' -H 'X-Forwarded-For: ${RANDOM_IP}'"

  if $verbose; then
    curl_cmd="curl ${curl_common}"
    echo "${i}: ${curl_cmd}"
    echo -ne "\033[32mResult:\033[0m "
    eval "${curl_cmd}"
    echo ""
    echo ""
  else
    curl_cmd="curl -s -o /dev/null ${curl_common}"
    eval "${curl_cmd}"
    echo -ne "Requests sent (GET): $((i))\r"
  fi

done

echo ""
echo ""
echo "FortiWeb API ML trained with POST method on ${PETSTORE_URL}/"
