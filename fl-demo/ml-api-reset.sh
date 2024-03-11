#!/bin/bash

# Define variables
echo "Defining variables..."
TOKEN=$(echo '{"username":"userapi","password":"fortinet123!"}' | base64)
FWB_MGT_IP="dvwa.canadaeast.cloudapp.azure.com"
PORT=8443
POLICY="PETSTORE_POLICY"
echo "Variables defined."

# Define base URL
BASE_URL="https://$FWB_MGT_IP:$PORT"
echo "Base URL defined as $BASE_URL"

# Perform GET request to fetch policy rules
echo "Performing GET request to fetch policy rules..."
RESPONSE=$(curl --insecure \
  --header "Authorization: $TOKEN" \
  --header "Accept: application/json" \
  "$BASE_URL/api/v2.0/machine_learning/api_learning_policy.get_policy_rule")
echo "GET request complete."

# Debug: print the response
echo "Response from GET request:"
echo "$RESPONSE"

# Parse JSON response and extract rule IDs for the specified policy
echo "Parsing JSON response to extract rule IDs..."
RULE_IDS=$(echo "$RESPONSE" | jq -r --arg POLICY "$POLICY" '.results[] | select(.["policy-name"]==$POLICY) | .rule[] | .id')
echo "Rule IDs extracted: $RULE_IDS"

# Loop over each rule ID and perform POST requests to refresh domain
echo "Starting POST requests to refresh domains..."
for ID in $RULE_IDS; do
    echo "Performing POST request for rule ID: $ID"
    curl --insecure \
         --header "Authorization: $TOKEN" \
         --header "Content-Type: application/json" \
         --request POST \
         "$BASE_URL/api/v2.0/machine_learning/api_learning_policy.refreshdomain?rule_id=$ID"
    echo "POST request for rule ID $ID completed."
done
echo "All POST requests completed."
