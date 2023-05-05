#!/bin/bash

# Variables
TOKEN="eyJ1c2VybmFtZSI6ImJlbm9pdGIiLCJwYXNzd29yZCI6ImFiYzEyMyIsInZkb20iOiJyb290In0K"
HOST="192.168.4.2"
POLICY="DVWA_POLICY"

# First step: Perform curl request and store the result
result=$(curl --insecure --location -g --request GET "https://${HOST}/api/v2.0/machine_learning/policy.getdomaininfo?policy_name=${POLICY}" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' | jq)

echo "------------------------"
echo "Step 1 Result: ${result}"
echo "------------------------"


# Second step: Get the db_id value
db_id=$(echo "$result" | jq '.results[0].db_id')

echo "------------------------------"
echo "Step 2 - db_id value: ${db_id}"
echo "------------------------------"


# Third step: Execute the command with the extracted db_id value

curl --insecure --location -g --request POST "https://${HOST}/api/v2.0/machine_learning/policy.refreshdomain" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' \
--data-raw '{"domain_id": "'${db_id}'", "policy_name": "'${POLICY}'"}'

echo " "
echo "-------------------------"
echo "Step 3 - Command executed"
echo "-------------------------"

