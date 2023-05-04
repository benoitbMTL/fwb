### bbuonassera@fortinet.com
### Last update 29 March 2023

### CONFIGURE TOKEN ###
TOKEN="eyJ1c2VybmFtZSI6InVzZXJhcGkiLCJwYXNzd29yZCI6ImZhY2VMT0NLeWFybjY3ISJ9Cg=="

### CONFIGURE HOST - Primary FortiWeb IP ###
#HOST="192.168.4.2"
HOST="10.163.7.21"

### SLOW DOWN SCRIPT
SLEEP=0.5

### NEW VIRTUAL IP 10.163.7.60 ###
echo "---------------------------------------------"
echo "Create new Virtual IP VIP1 10.163.7.60"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/system/vip' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "VIP1", "vip": "10.163.7.60/24", "interface": "port1"}}' | jq '.results | {"name", "vip", "interface"}'
sleep $SLEEP

### NEW VIRTUAL IP 10.163.7.70 ###
echo "---------------------------------------------"
echo "Create new Virtual IP VIP2 10.163.7.70"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/system/vip' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "VIP2", "vip": "10.163.7.70/24", "interface": "port1"}}' | jq '.results | {"name", "vip", "interface"}'
sleep $SLEEP

### NEW SERVER POOL ###
echo "---------------------------------------------"
echo "Create new Server Pool SERVER_POOL1"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "SERVER_POOL1", "server-balance": "enable", "health": "HLTHCK_HTTP"}}' | jq '.results | {"name", "server-balance", "health"}'
sleep $SLEEP

### NEW MEMBERS TO POOL ###
echo "---------------------------------------------"
echo "Create new Member Pool 10.0.0.10"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool/pserver-list?mkey=SERVER_POOL1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"ip": "10.0.0.10", "ssl": "enable", "port": 443}}' | jq '.results | {"ip", "ssl", "port"}'
sleep $SLEEP

echo "---------------------------------------------"
echo "Create new Member Pool 10.0.0.20"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool/pserver-list?mkey=SERVER_POOL1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"ip": "10.0.0.20", "ssl": "enable", "port": 443}}' | jq '.results | {"ip", "ssl", "port"}'
sleep $SLEEP

echo "---------------------------------------------"
echo "Create new Member Pool 10.0.0.30"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool/pserver-list?mkey=SERVER_POOL1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"ip": "10.0.0.30", "ssl": "enable", "port": 443}}' | jq '.results | {"ip", "ssl", "port"}'
sleep $SLEEP

### NEW SERVER POOL ###
echo "---------------------------------------------"
echo "Create new Server Pool SERVER_POOL2"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "SERVER_POOL2", "server-balance": "enable", "health": "HLTHCK_HTTP"}}' | jq '.results | {"name", "server-balance", "health"}'
sleep $SLEEP

### NEW MEMBERS TO POOL ###
echo "---------------------------------------------"
echo "Create new Member Pool 10.0.0.40"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool/pserver-list?mkey=SERVER_POOL2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"ip": "10.0.0.40", "ssl": "enable", "port": 443}}' | jq '.results | {"ip", "ssl", "port"}'
sleep $SLEEP

echo "---------------------------------------------"
echo "Create new Member Pool 10.0.0.50"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool/pserver-list?mkey=SERVER_POOL2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"ip": "10.0.0.50", "ssl": "enable", "port": 443}}' | jq '.results | {"ip", "ssl", "port"}'
sleep $SLEEP

echo "---------------------------------------------"
echo "Create new Member Pool 10.0.0.60"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool/pserver-list?mkey=SERVER_POOL2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"ip": "10.0.0.60", "ssl": "enable", "port": 443}}' | jq '.results | {"ip", "ssl", "port"}'
sleep $SLEEP

### NEW VIRTUAL SERVER ###
echo "---------------------------------------------"
echo "Create new Virtual Server VIRTUAL_SERVER1"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/vserver' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "VIRTUAL_SERVER1"}}' | jq '.results | {"name"}'
sleep $SLEEP

### ASSIGN VIP TO VIRTUAL SERVER ###
echo "---------------------------------------------"
echo "Assign VIP1 to VIRTUAL_SERVER1"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/vserver/vip-list?mkey=VIRTUAL_SERVER1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"interface": "port1", "status": "enable", "vip": "VIP1"}}' | jq '.results | {"interface", "status", "vip"}'
sleep $SLEEP

### NEW VIRTUAL SERVER ###
echo "---------------------------------------------"
echo "Create new Virtual Server VIRTUAL_SERVER2"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/vserver' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "VIRTUAL_SERVER2"}}' | jq '.results | {"name"}'
sleep $SLEEP

### ASSIGN VIP TO VIRTUAL SERVER ###
echo "---------------------------------------------"
echo "Assign VIP2 to VIRTUAL_SERVER2"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/vserver/vip-list?mkey=VIRTUAL_SERVER2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"interface": "port1", "status": "enable", "vip": "VIP2"}}' | jq '.results | {"interface", "status", "vip"}'
sleep $SLEEP

### CLONE SIGNATURE STANDARD PROTECTION ###
echo "---------------------------------------------"
echo "Cloning Signature Standard Protection..."
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/waf/signature?mkey=Standard%20Protection&clone_mkey=STANDARD_SIGNATURE_CLONE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {"name"}'
sleep $SLEEP

### NEW X-FORWARDED-FOR RULE ###
echo "---------------------------------------------"
echo "Create new X-Forwarded-For Rule"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/waf/x-forwarded-for' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "XFF", "x-forwarded-for-support": "enable"}}' | jq '.results | {"name", "x-forwarded-for-support", "x-real-ip"}'
sleep $SLEEP

### CLONE INLINE PROTECTION PROFILE ###
echo "---------------------------------------------"
echo "Cloning Inline Standard Protection..."
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/waf/web-protection-profile.inline-protection?mkey=Inline%20Standard%20Protection&clone_mkey=STANDARD_PROTECTION_CLONE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {"name"}'
sleep $SLEEP

### CONFIGURE PROTECTION PROFILE ###
echo "---------------------------------------------"
echo "Configure Protection Profile"
curl --silent --insecure --location -g --request PUT 'https://'$HOST'/api/v2.0/cmdb/waf/web-protection-profile.inline-protection?mkey=STANDARD_PROTECTION_CLONE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"signature-rule": "STANDARD_SIGNATURE_CLONE", "x-forwarded-for-rule": "XFF"}}' | jq '.results | {"name", "client-management", "signature-rule", "x-forwarded-for-rule", "file-upload-policy", "webshell-detection-policy", "ip-list-policy", "geo-block-list-policy", "custom-access-policy", "bot-mitigate-policy"}'
sleep $SLEEP

### IMPORT LOCAL CERTIFICATE ###
echo "---------------------------------------------"
echo "Import Local Certificate newapp.fabriclab.ca.crt"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/system/certificate.local.import_certificate' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--header 'Content-Type: multipart/form-data' \
--form 'certificateFile=@"newapp.fabriclab.ca.crt"' \
--form 'keyFile=@"newapp.fabriclab.ca.key"' \
--form 'type="certificate"' | jq
sleep $SLEEP

### NEW POLICY ###
echo "---------------------------------------------"
echo "Create new Policy POLICY1"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/policy' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"name": "POLICY1", "deployment-mode": "server-pool", "protocol": "HTTP", "ssl": "enable", "implicit_ssl": "enable", "vserver": "VIRTUAL_SERVER1", "service": "HTTP", "web-protection-profile": "STANDARD_PROTECTION_CLONE", "server-pool": "SERVER_POOL1", "tlog": "enable", "https-service": "HTTPS", "certificate": "newapp.fabriclab.ca"}}' | jq '.results | {"name", "deployment-mode", "protocol", "ssl", "implicit_ssl", "vserver", "service", "web-protection-profile", "server-pool", "tlog", "https-service", "certificate"}'
sleep $SLEEP

### NEW HTTP CONTENT ROUTE ###
echo "---------------------------------------------"
echo "Create new Content Route CONTENT_ROUTE1"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "CONTENT_ROUTE1", "server-pool": "SERVER_POOL1"}}' | jq '.results | {"name", "server-pool"}'
sleep $SLEEP

### NEW HTTP CONTENT ROUTE MATCHING CRITERIA ###
echo "---------------------------------------------"
echo "Create new Content Route Matching Criteria HOST=www.example1.com"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy/content-routing-match-list?mkey=CONTENT_ROUTE1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"match-object": "http-host", "match-condition": "equal", "match-expression": "www.example1.com", "concatenate": "and"}}' | jq '.results | {"match-object", "match-condition", "match-expression", "concatenate"}'
sleep $SLEEP

### NEW HTTP CONTENT ROUTE MATCHING CRITERIA ###
echo "---------------------------------------------"
echo "Create new Content Route Matching Criteria PATH=/app1"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy/content-routing-match-list?mkey=CONTENT_ROUTE1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"match-object": "http-request", "match-condition": "match-begin", "match-expression": "/app1", "concatenate": "and"}}' | jq '.results | {"match-object", "match-condition", "match-expression", "concatenate"}'
sleep $SLEEP

### NEW HTTP CONTENT ROUTE ###
echo "---------------------------------------------"
echo "Create new Content Route CONTENT_ROUTE2"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"name": "CONTENT_ROUTE2", "server-pool": "SERVER_POOL2"}}' | jq '.results | {"name", "server-pool"}'
sleep $SLEEP

### NEW HTTP CONTENT ROUTE MATCHING CRITERIA ###
echo "---------------------------------------------"
echo "Create new Content Route Matching Criteria HOST=www.example2.com"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy/content-routing-match-list?mkey=CONTENT_ROUTE2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"match-object": "http-host", "match-condition": "equal", "match-expression": "www.example2.com", "concatenate": "and"}}' | jq '.results | {"match-object", "match-condition", "match-expression", "concatenate"}'
sleep $SLEEP

### NEW HTTP CONTENT ROUTE MATCHING CRITERIA ###
echo "---------------------------------------------"
echo "Create new Content Route Matching Criteria PATH=/app2"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy/content-routing-match-list?mkey=CONTENT_ROUTE2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"match-object": "http-request", "match-condition": "match-begin", "match-expression": "/app2", "concatenate": "and"}}' | jq '.results | {"match-object", "match-condition", "match-expression", "concatenate"}'
sleep $SLEEP

### NEW POLICY ###
echo "---------------------------------------------"
echo "Create new Policy POLICY2"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/policy' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"name": "POLICY2", "deployment-mode": "http-content-routing", "protocol": "HTTP", "ssl": "enable", "implicit_ssl": "enable", "vserver": "VIRTUAL_SERVER2", "service": "HTTP", "web-protection-profile": "STANDARD_PROTECTION_CLONE", "tlog": "enable", "https-service": "HTTPS"}}' | jq '.results | {"name", "deployment-mode", "protocol", "ssl", "implicit_ssl", "vserver", "service", "tlog", "https-service"}'
sleep $SLEEP

### ASSIGN CONTENT ROUTE TO POLICY ###
echo "---------------------------------------------"
echo "Assign Content Route CONTENT_ROUTE1"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/policy/http-content-routing-list?mkey=POLICY2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"content-routing-policy-name": "CONTENT_ROUTE1", "profile-inherit": "enable", "web-protection-profile": "", "is-default": "yes", "status": "enable"}}' | jq '.results | {"content-routing-policy-name", "profile-inherit", "web-protection-profile", "is-default", "status"}'
sleep $SLEEP

### ASSIGN CONTENT ROUTE TO POLICY ###
echo "---------------------------------------------"
echo "Assign Content Route CONTENT_ROUTE2"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/server-policy/policy/http-content-routing-list?mkey=POLICY2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"content-routing-policy-name": "CONTENT_ROUTE2", "profile-inherit": "enable", "web-protection-profile": "", "is-default": "no", "status": "enable"}}' | jq '.results | {"content-routing-policy-name", "profile-inherit", "web-protection-profile", "is-default", "status"}'
sleep $SLEEP

## NEW URL REWRITE RULE ###
echo "---------------------------------------------"
echo "Create new URL Rewrite Rule URL_REWRITE_RULE"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/waf/url-rewrite.url-rewrite-rule' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"name": "URL_REWRITE_RULE", "action": "redirect-301", "location": "https://login.live.com/"}}' | jq '.results | {"name", "action", "location"}'
sleep $SLEEP

## NEW MATCH CONDITION ###
echo "---------------------------------------------"
echo "Create new Matching Condition URL=^/folder(.*)"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/waf/url-rewrite.url-rewrite-rule/match-condition?mkey=URL_REWRITE_RULE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"object": "http-url", "reg-exp": "^/folder(.*)"}}' | jq '.results | {"object", "reg-exp"}'
sleep $SLEEP

## NEW URL REWRITE POLICY ###
echo "---------------------------------------------"
echo "Create new Rewriting Policy URL_REWRITE_POLICY"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/waf/url-rewrite.url-rewrite-policy' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"name": "URL_REWRITE_POLICY"}}' | jq '.results | {"name"}'
sleep $SLEEP

## NEW RULE TO REWRITE POLICY ###
echo "---------------------------------------------"
echo "Create new Rule to Rewriting Policy"
curl --silent --insecure --location -g --request POST 'https://'$HOST'/api/v2.0/cmdb/waf/url-rewrite.url-rewrite-policy/rule?mkey=URL_REWRITE_POLICY' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{ "data":{"url-rewrite-rule-name": "URL_REWRITE_RULE"}}' | jq '.results | {"url-rewrite-rule-name"}'
sleep $SLEEP

### ADD REWRITING POLICY TO PROTECTION PROFILE ###
echo "---------------------------------------------"
echo "Add Rewriting Rule to Protection Profile"
curl --silent --insecure --location -g --request PUT 'https://'$HOST'/api/v2.0/cmdb/waf/web-protection-profile.inline-protection?mkey=STANDARD_PROTECTION_CLONE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' \
--data-raw '{"data":{"url-rewrite-policy": "URL_REWRITE_POLICY"}}' | jq '.results | {"name", "url-rewrite-policy"}'
sleep $SLEEP

### END
echo "---------------------------------------------"
