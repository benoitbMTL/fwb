# bbuonassera May 12, 2023
#!/bin/bash

rm -Rf /var/www/html/report/report
skipfish -u -k 0:0:30 -o /var/www/html/report/report http://dvwa.corp.fabriclab.ca
echo "*HELPERUSERMESSAGE:*"
echo "Done! Check the Attack Logs. Scan Report available at https://flbr1kali01.fortiweb.fabriclab.ca"
exit 0