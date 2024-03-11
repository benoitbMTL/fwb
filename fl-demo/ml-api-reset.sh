#!/bin/bash

# Define variables
TOKEN=$(echo '{"username":"userapi","password":"fortinet123!"}' | base64)
FWB_MGT_IP="dvwa.canadaeast.cloudapp.azure.com"
PORT=8443
POLICY="PETSTORE_POLICY"

# Define base URL
BASE_URL="https://$FWB_MGT_IP:$PORT"

# Perform GET request to fetch policy rules
RESPONSE=$(curl --insecure \
  --header "Authorization: Bearer $TOKEN" \
  --header "Accept: application/json" \
  "$BASE_URL/api/v2.0/machine_learning/api_learning_policy.get_policy_rule")

# Parse JSON response and extract rule IDs for the specified policy
RULE_IDS=$(echo "$RESPONSE" | jq -r --arg POLICY "$POLICY" '.results[] | select(.["policy-name"]==$POLICY) | .rule[] | .id')

# Loop over each rule ID and perform POST requests to refresh domain
for ID in $RULE_IDS; do
    curl --insecure \
         --header "Authorization: Bearer $TOKEN" \
         --header "Content-Type: application/json" \
         --request POST \
         "$BASE_URL/api/v2.0/machine_learning/api_learning_policy.refreshdomain?rule_id=$ID"
done
