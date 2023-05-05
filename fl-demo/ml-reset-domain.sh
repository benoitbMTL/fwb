### bbuonassera@fortinet.com
### Last update 05 May 2023

### CONFIGURE TOKEN ###
TOKEN="eyJ1c2VybmFtZSI6InVzZXJhcGkiLCJwYXNzd29yZCI6ImZhY2VMT0NLeWFybjY3ISJ9Cg=="

### CONFIGURE HOST - Primary FortiWeb IP ###
#HOST="192.168.4.2"
HOST="10.163.7.21"

### CONFIGURE POLICY NAME
POLICY="DVWA_POLICY"

### getdomaininfo and store result
echo "Get Domain Info"
result=$(curl --insecure --location -g --request GET "https://${HOST}/api/v2.0/machine_learning/policy.getdomaininfo?policy_name=${POLICY}" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' | jq)

echo "-------------------------------------"
#echo "Step 1 Result: ${result}"
echo "-------------------------------------"


# Get the db_id value
db_id=$(echo "$result" | jq '.results[0].db_id')

echo "-------------------------------------"
echo "Domain db_id to reset is: ${db_id}"
echo "-------------------------------------"


# Execute the command with the extracted db_id value

curl --insecure --location -g --request POST "https://${HOST}/api/v2.0/machine_learning/policy.refreshdomain" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' \
--data-raw '{"domain_id": "'${db_id}'", "policy_name": "'${POLICY}'"}'

echo "-------------------------------------"
echo "Machine Learning for domain is reset"
echo "-------------------------------------"
