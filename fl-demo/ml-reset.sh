#!/bin/bash

# Encode username and password in base64 and assign to TOKEN
TOKEN=$(echo '{"username":"userapi","password":"userAPI123!"}' | base64)
FWB_MGT_IP="10.163.7.21"
POLICY="main-policy"

echo ""
echo "Getting ML Domain Info:"
echo ""

# Command for getting ML domain information
get_domain_info_cmd="curl --insecure --location -g --request GET \"https://${FWB_MGT_IP}/api/v2.0/machine_learning/policy.getdomaininfo?policy_name=${POLICY}\" --header \"Authorization: ${TOKEN}\" --header 'accept: application/json'"
echo $get_domain_info_cmd
echo ""

# Execute the command and store the result
result=$(eval $get_domain_info_cmd | jq)
echo $result
echo ""

# Extract db_id and domain_name
db_id=$(echo "$result" | jq '.results[0].db_id')
domain_name=$(echo "$result" | jq '.results[0].domain_name')

echo "Domain ${domain_name} has db_id ${db_id}"
echo ""

echo "Resetting Machine Learning for Domain ${domain_name}"
echo ""

# Command for resetting ML
reset_ml_cmd="curl --insecure --location -g --request POST \"https://${FWB_MGT_IP}/api/v2.0/machine_learning/policy.refreshdomain\" --header \"Authorization: ${TOKEN}\" --header \"accept: application/json\" --header \"Content-Type: application/json\" --data-raw '{\"domain_id\": ${db_id}, \"policy_name\": \"${POLICY}\"}'"
echo $reset_ml_cmd
echo ""

# Execute the command and output the result
eval $reset_ml_cmd

echo ""
echo "Machine Learning for domain ${domain_name} has been reset. Press enter to continue..."
