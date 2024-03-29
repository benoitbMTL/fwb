#!/bin/bash

PETSTORE_URL='http://petstore.corp.fabriclab.ca/api/v3'
#PETSTORE_URL='https://petstore.buonassera.fr/api/v3'
USER_AGENT="ML-API-Demo-Tool"

REQUESTS=1500

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

echo "Sending ${REQUESTS} POST/GET/PUT/DELETE API calls to ${PETSTORE_URL}"
echo ""

for ((i=1; i<=$REQUESTS; i++))
do
  # Generate random values for NAMES, PETS, STATUS, and IPs
  RANDOM_NAME=$(generate_random_value "FortiPuma" "FortiFish" "FortiSpider" "FortiTiger" "FortiLion" "FortiShark" "FortiSnake" "FortiMonkey" "FortiFox" "FortiRam" "FortiEagle" "FortiBee" "FortiCat" "FortiDog" "FortiAnt" "FortiWasp" "FortiPanter" "FortiGator" "FortiOwl" "FortiWildcats")
  RANDOM_PET=$(generate_random_value "Puma" "Fish" "Spider" "Tiger" "Lion" "Shark" "Snake" "Monkey" "Fox" "Ram" "Eagle" "Bee" "Cat" "Dog" "Ant" "Wasp" "Panter" "Gator" "Owl" "Wildcats")
  RANDOM_PHOTO=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_@{}[]()' | fold -w $((RANDOM % 9 + 2)) | head -n 1).png
  RANDOM_STATUS=$(generate_random_value "available" "pending" "sold")
  RANDOM_STATUS_NEW=$(generate_random_value "available" "pending" "sold")
  RANDOM_IP=$(shuf -i 1-254 -n 4 | paste -sd '.')
  RANDOM_ID=$(shuf -i 1000-1999 -n 1)
  
  curl_post="--insecure --user-agent '${USER_AGENT}' --request 'POST' '${PETSTORE_URL}/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -H 'X-Forwarded-For: ${RANDOM_IP}' -d '{\"id\": $RANDOM_ID, \"category\": {\"id\": $RANDOM_ID, \"name\": \"${RANDOM_PET}\"}, \"name\": \"${RANDOM_NAME}\", \"photoUrls\": [\"${RANDOM_PHOTO}\"], \"tags\": [{\"id\": $RANDOM_ID, \"name\": \"${RANDOM_NAME}\"}], \"status\": \"${RANDOM_STATUS}\"}'"
  curl_get="--insecure --silent --user-agent '${USER_AGENT}' --request 'GET' '${PETSTORE_URL}/pet/findByStatus?status=${RANDOM_STATUS}' -H 'accept: application/json' -H 'Content-Type: application/json' -H 'X-Forwarded-For: ${RANDOM_IP}' | jq length"
  curl_put="--insecure --user-agent '${USER_AGENT}' --request 'PUT' '${PETSTORE_URL}/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -H 'X-Forwarded-For: ${RANDOM_IP}' -d '{\"id\": $RANDOM_ID, \"category\": {\"id\": $RANDOM_ID, \"name\": \"${RANDOM_PET}\"}, \"name\": \"${RANDOM_NAME}\", \"photoUrls\": [\"${RANDOM_PHOTO}\"], \"tags\": [{\"id\": $RANDOM_ID, \"name\": \"${RANDOM_NAME}\"}], \"status\": \"${RANDOM_STATUS_NEW}\"}'"
  curl_delete="--insecure --silent --user-agent '${USER_AGENT}' --request 'DELETE' '${PETSTORE_URL}/pet/${RANDOM_ID}' -H 'accept: application/json' -H 'Content-Type: application/json' -H 'X-Forwarded-For: ${RANDOM_IP}'"

  if $verbose; then
    curl_cmd="curl ${curl_post}"
    echo "${i}: ${curl_cmd}"
    echo -ne "\033[32mPOST Result:\033[0m "
    eval "${curl_cmd}"
    echo ""
    echo ""
    curl_cmd="curl ${curl_get}"
    echo "${i}: ${curl_cmd}"
    echo -ne "\033[32mNumber of entries:\033[0m "
    eval "${curl_cmd}"
    echo ""
    curl_cmd="curl ${curl_put}"
    echo "${i}: ${curl_cmd}"
    echo -ne "\033[32mPUT Result:\033[0m "
    eval "${curl_cmd}"
    echo ""
    echo ""
    curl_cmd="curl ${curl_delete}"
    echo "${i}: ${curl_cmd}"
    echo -ne "\033[32mDELETE Result:\033[0m "
    eval "${curl_cmd}"
    echo ""
    echo ""
    echo ""
  else
    curl_cmd="curl -s -o /dev/null ${curl_post}"
    eval "${curl_cmd}"
    curl_cmd="curl -s -o /dev/null ${curl_get}"
    eval "${curl_cmd}"
    curl_cmd="curl -s -o /dev/null ${curl_put}"
    eval "${curl_cmd}"
    curl_cmd="curl -s -o /dev/null ${curl_delete}"
    eval "${curl_cmd}"
    printf "Requests: %03d | Random ID: $RANDOM_ID | Random IP: $RANDOM_IP\t\t\r" $i
  fi
done

echo ""
echo ""
echo -e "\033[1;31mDone!\033[0m"
