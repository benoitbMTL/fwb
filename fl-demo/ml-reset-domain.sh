### bbuonassera@fortinet.com
### Last update May 14, 2023

### CONFIGURE TOKEN ###
TOKEN="eyJ1c2VybmFtZSI6InVzZXJhcGkiLCJwYXNzd29yZCI6ImZhY2VMT0NLeWFybjY3ISJ9Cg=="

### CONFIGURE HOST - Primary FortiWeb IP
#HOST="192.168.4.2"
HOST="10.163.7.21"

### CONFIGURE POLICY NAME
POLICY="main-policy"

############################################################################
## Colors
############################################################################
BOLD='\033[1m'
RESTORE='\033[0m'
RED='\033[00;31m'
RED_BOLD='\033[1;31m'
GREEN='\033[00;32m'
GREEN_BOLD='\033[1;32m'
YELLOW='\033[00;33m'
YELLOW_BOLD='\033[1;33m'
CYAN_BOLD='\033[00;34m'
CYAN_BOLD_BOLD='\033[1;34m'
PURPLE='\033[00;35m'
PURPLE_BOLD='\033[1;35m'
CYAN='\033[00;36m'
CYAN_BOLD='\033[1;36m'
LIGHTGRAY='\033[00;37m'
LIGHTGRAY_BOLD='\033[1;37m'
WHITE='\033[37m'
WHITE_BOLD='\033[1;37m'

### getdomaininfo and store result
echo ""
echo "Getting ML Domain Info:"
echo ""

result=$(curl --silent --insecure --location -g --request GET "https://${HOST}/api/v2.0/machine_learning/policy.getdomaininfo?policy_name=${POLICY}" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' | jq)

#echo "---------------------------------------------------------------------------"
echo "${GREEN_BOLD}${result}${RESTORE}"
#echo "---------------------------------------------------------------------------"
echo ""

# Get the db_id value
db_id=$(echo "$result" | jq '.results[0].db_id')
domain_name=$(echo "$result" | jq '.results[0].domain_name')

echo "Domain ${domain_name} has db_id ${db_id}"
echo ""

# Execute the command with the extracted db_id value
echo "Resetting Machine Learning for Domain ${domain_name}"
echo ""

curl --insecure --location -g --request POST "https://${HOST}/api/v2.0/machine_learning/policy.refreshdomain" \
--header "Authorization: ${TOKEN}" \
--header 'accept: application/json' \
--data-raw '{"domain_id": "'${db_id}'", "policy_name": "'${POLICY}'"}'

echo ""
echo ""
echo "[+] Machine Learning for domain ${domain_name} has been reset"
