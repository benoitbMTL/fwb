#!/bin/bash

# Encode username and password in base64 and assign to TOKEN
TOKEN=$(echo '{"username":"userapi","password":"userAPI123!"}' | base64)
FWB_MGT_IP="10.163.7.21"
POLICY="main-policy"

echo ""
echo "Getting ML Domain Info:"
echo ""

# Retrieve ML domain information
result=$(curl --silent --insecure --location -g --request GET "https://${FWB_MGT_IP}/api/v2.0/machine_learning/policy.getdomaininfo?policy_name=${POLICY}" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' | jq)

echo "$result"
echo ""

# Extract db_id and domain_name
db_id=$(echo "$result" | jq '.results[0].db_id')
domain_name=$(echo "$result" | jq '.results[0].domain_name')

echo "Domain ${domain_name} has db_id ${db_id}"
echo ""

echo "Resetting Machine Learning for Domain ${domain_name}"
echo ""

# Execute the command with the extracted db_id value
curl --insecure --location -g --request POST "https://${FWB_MGT_IP}/api/v2.0/machine_learning/policy.refreshdomain" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' \
--data-raw '{"domain_id": "'${db_id}'", "policy_name": "'${POLICY}'"}'

echo ""
echo "Machine Learning for domain ${domain_name} has been reset. Press enter to continue..."