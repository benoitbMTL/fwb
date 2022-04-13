#!/bin/bash

for (( i=1; i<=10; i++))
	do
		id=$((100000 + $i))
		echo "Create user kapler$i (POST)"
		curl --silent  --insecure -X 'POST' 'https://petstore.swagger.io/v2/user' \
			-H 'accept: application/json' -H 'Content-Type: application/json' \
			-d "{\"id\": \"$id\", \"username\": \"kapler$i\", \"firstName\": \"Robert\", \"lastName\": \"Kapler\", \"email\": \"kapler$i@net.com\", \"password\": \"abc123\", \"phone\": \"5141234567\", \"userStatus\": \"1\"}" \
			| jq '.message'
		echo "Get user kapler$i (GET)"
		curl --silent --insecure -X 'GET' "https://petstore.swagger.io/v2/user/kapler$i" -H 'accept: application/json' | jq '.username'
		echo "Login with user kapler$i (GET)"
		curl --silent --insecure -X 'GET' "https://petstore.swagger.io/v2/user/login?username=kapler$1&password=abc123" -H 'accept: application/json' | jq '.message'
		echo "Logout with user kapler$i (GET)"
		curl --silent --insecure -X 'GET' 'https://petstore.swagger.io/v2/user/logout' -H 'accept: application/json' | jq '.message'
		echo "Delete user kapler$i (DELETE)"
		curl --silent --insecure -X 'DELETE' "https://petstore.swagger.io/v2/user/kapler$i" -H 'accept: application/json' | jq '.message'
	done

for (( i=1; i<=10; i++))
	do
		id=$((100000 + $i))
		
		echo "Add dog$i to the store (POST)"
		curl --silent --insecure -X 'POST' 'https://petstore.swagger.io/v2/pet' \
			-H 'accept: application/json' -H 'Content-Type: application/json' \
			-d "{\"id\": \"$id\",\"category\": {\"id\": \"$id\", \"name\": \"category$i\"}, \"name\": \"dog$i\", \"photoUrls\": [\"www.google.com/dog$i.png\"], \"tags\": [{\"id\": \"$i\", \"name\": \"tag$i\" }], \"status\": \"available\" }" | jq  '.name'

		echo "Update dog$i status (PUT)"
		curl --silent --insecure -X 'POST' 'https://petstore.swagger.io/v2/pet' \
			-H 'accept: application/json' -H 'Content-Type: application/json' \
			-d "{\"id\": \"$id\",\"category\": {\"id\": \"$id\", \"name\": \"category$i\"}, \"name\": \"dog$i\", \"photoUrls\": [\"www.google.com/dog$i.png\"], \"tags\": [{\"id\": \"$i\", \"name\": \"tag$i\" }], \"status\": \"sold\" }" | jq '.status'
			
		echo "Update dog$i status (PUT)"
		curl --silent --insecure -X 'POST' 'https://petstore.swagger.io/v2/pet' \
			-H 'accept: application/json' -H 'Content-Type: application/json' \
			-d "{\"id\": \"$id\",\"category\": {\"id\": \"$id\", \"name\": \"category$i\"}, \"name\": \"dog$i\", \"photoUrls\": [\"www.google.com/dog$i.png\"], \"tags\": [{\"id\": \"$i\", \"name\": \"tag$i\" }], \"status\": \"pending\" }" | jq '.status'
			
		echo "Get dog$i status (GET)"
		curl --silent --insecure -X 'GET' "https://petstore.swagger.io/v2/pet/$id" -H 'accept: application/json' | jq '.status'
		
#		echo "Pending Status (GET)"
#		curl --silent --insecure curl -X 'GET' 'https://petstore.swagger.io/v2/pet/findByStatus?status=pending' -H 'accept: application/json' | wc -wc
		
		echo "Find pet in the Store (GET)"
		curl --silent --insecure -X 'GET' "https://petstore.swagger.io/v2/pet/$id" -H 'accept: application/json' | jq '.name'
		
		echo "Delete pet from the Store (DELETE)"
		curl --silent --insecure -X 'GET' "https://petstore.swagger.io/v2/pet/$id" -H 'accept: application/json' | jq '.name'
			
	done
