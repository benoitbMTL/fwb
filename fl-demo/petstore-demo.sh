#!/bin/bash

curl -v -X GET 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=available' -H 'accept: application/json' -H 'content-type: application/json'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=sold' -H 'Accept: application/json' -H 'Content-Type: application/json'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=pending' -H 'Accept: application/json' -H 'Content-Type: application/json'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?' -H 'Accept: application/json' -H 'Content-Type: application/json'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=ABCDEFGHIJKL' -H 'Accept: application/json' -H 'Content-Type: application/json'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=A' -H 'Accept: application/json' -H 'Content-Type: application/json'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=;cmd.exe' -H 'Accept: application/json' -H 'Content-Type: application/json'

curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/api/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"id": 110, "category": {"id": 110, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["Willupdatelater"], "tags": [ {"id": 110, "name": "FortiCamel"}], "status": "ls;;cmd.exe"}'

curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/api/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["WillUpdatelater"], "tags": [ {"id": 111, "name": "FortiCamel"}], "status": "xx& var1=l var2=s;$var1$var2"}'

curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/api/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["WillUpdateLater"], "tags": [ {"id": 111, "name": "FortiCamel"}], "status": "<script>alert(123)</script>"}'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=sold&status=pending' -H 'accept: application/json' -H 'Content-Type: application/json'

curl -v -X 'GET' 'http://petstore.corp.fabriclab.ca/api/pet/findByStatus?status=sold' -H 'accept: application/yaml' -H 'Content-Type: application/json'

curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/api/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"id": 110, "category": {"id": 110, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["Willupdatelater"], "tags": [ {"id": 110, "name": "FortiCamel"}], "status": "ls;;cmd.exe"}'

curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/api/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["WillUpdateLater"], "tags": [ {"id": 111, "name": "FortiCamel"}], "status": "<script>alert(123)</script>"}'

curl -v -X 'POST' 'http://petstore.corp.fabriclab.ca/api/pet' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"id": 111, "category": {"id": 111, "name": "Camel"}, "name": "FortiCamel", "photoUrls": ["WillUpdatelater"], "tags": [ {"id": 111, "name": "FortiCamel"}], "status": "xx& var1=l var2=s;$var1$var2"}'

