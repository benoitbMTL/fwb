#!/bin/bash

# Global variable
DVWA_URL=https://dvwa.corp.fabriclab.ca
DVWA_HOST=dvwa.corp.fabriclab.ca

# Step 1: Remove existing cookie file
echo "Removing cookie file..."
rm -Rf cookie.txt

# Step 2: Perform a curl request to authenticate
echo "Authenticating..."
curl "${DVWA_URL}/login.php" \
     -H "authority: ${DVWA_HOST}" \
     -H "cache-control: max-age=0" \
     -H "content-type: application/x-www-form-urlencoded" \
     -H "origin: ${DVWA_URL}" \
     -H "referer: ${DVWA_URL}/" \
     -H "user-agent: FortiWeb Demo Script" \
     --insecure \
     --data-raw "username=pablo&password=letmein&Login=Login" \
     -c cookie.txt

# Step 3: Get PHPSESSID value from cookie.txt
echo "Extracting PHPSESSID..."
PHPSESSID=$(grep PHPSESSID cookie.txt | awk '{print $7}')
echo "PHPSESSID: $PHPSESSID"

# Step 4: Generate random IPv4 addresses for random countries
echo "Enter the number of countries needed:"
read NCOUNTRIES
echo "Generating $NCOUNTRIES random IP addresses..."

for ((i=1; i<=NCOUNTRIES; i++))
do
    # Generate random IP (Placeholder logic, replace with actual IP generation logic)
    RANDOM_IP=$(shuf -i 1-255 -n 4 | tr "\n" "." | sed 's/\.$//')
    echo "IP$i for Country$i: $RANDOM_IP"
    IP_ARRAY[i]=$RANDOM_IP
done

# Step 5: Loop to use skipfish on each IP
echo "Running skipfish on each IP..."
for IP in "${IP_ARRAY[@]}"
do
    rm -Rf report
    echo "Using IP: $IP"
    skipfish -H "X-Forwarded-For=$IP" -C "PHPSESSID=$PHPSESSID" -u -k 0:0:05 -o report "$DVWA_URL"
    echo "skipfish completed for IP: $IP"
done

echo "Script execution completed."
