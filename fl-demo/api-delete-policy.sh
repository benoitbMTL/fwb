### CONFIGURE TOKEN ###
TOKEN=$(echo '{"username":"userapi","password":"userAPI123!","vdom":"root"}' | base64)
echo $TOKEN

### CONFIGURE HOST - Primary FortiWeb IP ###
#HOST="192.168.4.2"
HOST="10.163.7.21"

### SLOW DOWN SCRIPT
SLEEP=0.5

### DELETE POLICY ###
echo "---------------------------------------------------------"
echo "Deleting Policy POLICY1..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/policy?mkey=POLICY1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE POLICY ###
echo "---------------------------------------------------------"
echo "Deleting Policy POLICY2..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/policy?mkey=POLICY2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE LOCAL CERTIFICATE ###
echo "---------------------------------------------------------"
echo "Deleting Local Certificate newapp.fabriclab.ca..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/system/certificate.local?mkey=newapp.fabriclab.ca' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE PROTECTION PROFILE ###
echo "---------------------------------------------------------"
echo "Deleting Protection Profile STANDARD_PROTECTION_CLONE..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/waf/web-protection-profile.inline-protection?mkey=STANDARD_PROTECTION_CLONE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE X-FORWARDED-FOR RULE ###
echo "---------------------------------------------------------"
echo "Deleting X-Forwarded-For Rule..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/waf/x-forwarded-for?mkey=XFF' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE SIGNATURE PROTECTION ###
echo "---------------------------------------------------------"
echo "Deleting Signature Protection STANDARD_SIGNATURE_CLONE..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/waf/signature?mkey=STANDARD_SIGNATURE_CLONE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE Virtual Server ###
echo "---------------------------------------------------------"
echo "Deleting Virtual Server VIRTUAL_SERVER1..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/vserver?mkey=VIRTUAL_SERVER1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE Virtual Server ###
echo "---------------------------------------------------------"
echo "Deleting Virtual Server VIRTUAL_SERVER2..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/vserver?mkey=VIRTUAL_SERVER2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE VIRTUAL IP ###
echo "---------------------------------------------------------"
echo "Deleting Virtual IP VIP1..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/system/vip?mkey=VIP1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE VIRTUAL IP ###
echo "---------------------------------------------------------"
echo "Deleting Virtual IP VIP2..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/system/vip?mkey=VIP2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE HTTP CONTENT ROUTE ###
echo "---------------------------------------------------------"
echo "Deleting Content Route CONTENT_ROUTE1..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy?mkey=CONTENT_ROUTE1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE HTTP CONTENT ROUTE ###
echo "---------------------------------------------------------"
echo "Deleting Content Route CONTENT_ROUTE2..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/http-content-routing-policy?mkey=CONTENT_ROUTE2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE SERVER POOL ###
echo "---------------------------------------------------------"
echo "Deleting Server Pool SERVER_POOL1..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool?mkey=SERVER_POOL1' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### DELETE SERVER POOL ###
echo "---------------------------------------------------------"
echo "Deleting Server Pool SERVER_POOL2..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/server-policy/server-pool?mkey=SERVER_POOL2' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

## DELETE URL REWRITE POLICY ###
echo "---------------------------------------------------------"
echo "Deleting Rewriting Policy URL_REWRITE_POLICY..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/waf/url-rewrite.url-rewrite-policy?mkey=URL_REWRITE_POLICY' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

## DELETE URL REWRITE RULE ###
echo "---------------------------------------------------------"
echo "Deleting URL Rewrite Rule URL_REWRITE_RULE..."
curl --silent --insecure --location -g --request DELETE 'https://'$HOST'/api/v2.0/cmdb/waf/url-rewrite.url-rewrite-rule?mkey=URL_REWRITE_RULE' \
--header 'Authorization: '$TOKEN \
--header 'Accept: application/json' | jq '.results | {status}'
sleep $SLEEP

### END
echo "---------------------------------------------------------"

