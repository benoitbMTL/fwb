#!/bin/bash

PETSTORE_URL='https://petstore.buonassera.fr/api/v3'
#PETSTORE_URL='http://petstore.corp.fabriclab.ca/api/v3'

ID=420

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
  RANDOM_IP=$(generate_random_value "192.168.1.100" "10.0.0.1" "172.16.0.1" "192.0.2.1" "198.51.100.1" "203.0.113.1" "192.168.0.1" "10.10.10.1" "172.17.0.1" "192.168.10.1" "10.20.30.1" "172.18.0.1" "192.168.20.1" "10.30.40.1" "172.19.0.1" "192.168.30.1" "10.40.50.1" "172.20.0.1" "192.168.40.1" "10.50.60.1")

  curl_common="-k -A ML-API-Demo-Tool -X 'POST' '${PETSTORE_URL}/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -H 'X-Forwarded-For: ${RANDOM_IP}' -d '{\"id\": $ID, \"category\": {\"id\": $ID, \"name\": \"${RANDOM_PET}\"}, \"name\": \"${RANDOM_NAME}\", \"photoUrls\": [\"http://surl.li/imgkr\"], \"tags\": [{\"id\": $ID, \"name\": \"${RANDOM_NAME}\"}], \"status\": \"${RANDOM_STATUS}\"}'"

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

  ID=$((ID+1))
done

echo ""
echo ""
echo "FortiWeb API ML trained with POST method on ${PETSTORE_URL}/"
