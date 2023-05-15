#!/bin/bash

#!/bin/bash

options=(
    "findByStatus?status=available"
    "findByStatus?status=sold"
    "findByStatus?status=pending"
    "findByStatus? (schema violation)"
    "findByStatus?status=ABCDEFGHIJKL (URL too long)"
    "findByStatus?status=A (URL too short)"
    "findByStatus?status=;cmd.exe (Command Injection in URL)"
    "{\"status\": \"ls;;cmd.exe\"} (Command Injection in JSON)"
    "{\"status\": \"xx& var1=l var2=s;$var1$var2\"} (Zero-Day in JSON)"
    "{\"status\": \"<script>alert(123)</script>\"} (XSS in JSON)"
    "findByStatus?status=sold&status=pending (Additional URL parameter)"
    "accept: application/yaml (Non JSON request)"
    "{\"status\": \"ls;;cmd.exe\"} (Command Injection in JSON)"
    "{\"status\": \"<script>alert(123)</script>\"} (XSS in JSON)"
    "{\"status\": \"xx& var1=l var2=s;$var1$var2\"} (Zero-Day in JSON)"
)

curl_commands=(
    "curl -v -X GET 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=available' -H 'accept: application/json' -H 'content-type: application/json'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=sold' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=pending' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=ABCDEFGHIJKL' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=A' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=;cmd.exe' -H 'Accept: application/json' -H 'Content-Type: application/json'"
    "curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/v2/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 110, \"category\": {\"id\": 110, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"Willupdatelater\"], \"tags\": [ {\"id\": 110, \"name\": \"FortiCamel\"}], \"status\": \"ls;;cmd.exe\"}'"
    "curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/v2/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"Willupdatelater\"], \"tags\": [ {\"id\": 111, \"name\": \"FortiCamel\"}], \"status\": \"xx& var1=l var2=s;$var1$var2\"}'"
    "curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/v2/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"Willupdatelater\"], \"tags\": [ {\"id\": 111, \"name\": \"FortiCamel\"}], \"status\": \"<script>alert(123)</script>\"}'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=sold&status=pending' -H 'accept: application/json' -H 'Content-Type: application/json'"
    "curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/v2/pet/findByStatus?status=sold' -H 'accept: application/yaml' -H 'Content-Type: application/json'"
    "curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/v2/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 110, \"category\": {\"id\": 110, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"Willupdatelater\"], \"tags\": [ {\"id\": 110, \"name\": \"FortiCamel\"}], \"status\": \"ls;;cmd.exe\"}'"
    "curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/v2/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"Willupdatelater\"], \"tags\": [ {\"id\": 111, \"name\": \"FortiCamel\"}], \"status\": \"<script>alert(123)</script>\"}'"
    "curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/v2/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{\"id\": 111, \"category\": {\"id\": 111, \"name\": \"Camel\"}, \"name\": \"FortiCamel\", \"photoUrls\": [\"Willupdatelater\"], \"tags\": [ {\"id\": 111, \"name\": \"FortiCamel\"}], \"status\": \"xx& var1=l var2=s;$var1$var2\"}'"
)

select_option() {
    echo "Choose an option:"
    for i in "${!options[@]}"; do
        echo "$((i+1)). ${options[$i]}"
    done
    read -p "Enter your choice (1-${#options[@]}): " choice
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#options[@]} )); then
        echo "Invalid choice. Please try again."
        select_option
    fi
    execute_curl $((choice-1))
}

execute_curl() {
    local index=$1
    local command=${curl_commands[$index]}
    echo "Executing CURL command:"
    echo "$command"
    echo
    output=$(eval $command 2>&1)
    if [[ $? -eq 0 ]]; then
        echo "Connection successful."
        echo
        echo "Response:"
        echo "$output"
    else
        echo "Connection failed."
        echo
        echo "Error message:"
        echo "$output"
    fi
    echo
    read -p "Press Enter to continue..."
    select_option
}

select_option



