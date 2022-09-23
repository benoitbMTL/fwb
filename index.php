<?php
header('Content-type: text/plain');

echo "Welcome! You are connected on:\r\n\r\n";
echo "HOSTNAME:       " . gethostname() . "\r\n";
echo "HOST:           " . $_SERVER['SERVER_ADDR'] . "\r\n";
echo "PORT:           " . $_SERVER['SERVER_PORT'] . "\r\n";
echo "URL:            " . $_SERVER['REQUEST_URI'] . "\r\n";
echo "HTTPS:          " . $_SERVER['HTTPS']       . "\r\n";
echo "SNI:            " . $_SERVER['SSL_TLS_SNI'] . "\r\n";

echo "\r\n";
echo "---------------------------------------------------------------------------\r\n";
echo "\r\n";

$ip_hostname = gethostbyname($_SERVER['SERVER_NAME']);
$ns = dns_get_record($_SERVER['SERVER_NAME']);
$ip_ns = $ns[0];
#echo "hostname:    " . $ip_hostname . "\r\n";
#echo "nslookup:    " . $ip_ns['ip'] . "\r\n";

if ($_SERVER['HTTP_X_FORWARDED_FOR'] != "" AND $ip_ns['ip'] != "") {
        echo "" . $_SERVER['HTTP_X_FORWARDED_FOR'] . " ----> " . $ip_ns['ip'] . " ----> " . $_SERVER['REMOTE_ADDR'] . " ----> " . $_SERVER['SERVER_ADDR'] . "\r\n";
} elseif ($_SERVER['HTTP_X_FORWARDED_FOR'] != "" AND $ip_hostname !== "") {
        echo "" . $_SERVER['HTTP_X_FORWARDED_FOR'] . " ----> " . $ip_hostname . " ----> " . $_SERVER['REMOTE_ADDR'] . " ----> " . $_SERVER['SERVER_ADDR'] . "\r\n";
} elseif ($ip_hostname != $ip_ns['ip']) {
        echo "Client ----> " . $ip_hostname . " ----> " . $_SERVER['REMOTE_ADDR'] . " ----> " . $_SERVER['SERVER_ADDR'] . "\r\n";
} else {
        echo "Client ----> " . $_SERVER['REMOTE_ADDR'] . " ----> " . $_SERVER['SERVER_ADDR'] . "\r\n";
}



echo "\r\n";
echo "---------------------------------------------------------------------------\r\n";
echo "\r\n";

echo "https://" . $_SERVER['SERVER_NAME'] . "/dvwa\r\n";
echo "https://" . $_SERVER['SERVER_NAME'] . "/pci.html\r\n";
echo "https://" . $_SERVER['SERVER_NAME'] . "/wso.php\r\n";
echo "https://" . $_SERVER['SERVER_NAME'] . "/badsite.html\r\n";

echo "\r\n";
echo "---------------------------------------------------------------------------\r\n";
echo "\r\n";

echo "PHPSESSID:           " . $_COOKIE["PHPSESSID"] . "\r\n";
echo "Security:            " . $_COOKIE["security"] . "\r\n";

echo "\r\n";
echo "---------------------------------------------------------------------------\r\n";
echo "\r\n";

echo "REMOTE_ADDR:         " . $_SERVER['REMOTE_ADDR'] . "\r\n";
echo "REMOTE_PORT:         " . $_SERVER['REMOTE_PORT'] . "\r\n";
echo "REMOTE_HOST:         " . $_SERVER['REMOTE_HOST'] . "\r\n";
echo "REMOTE_USER:         " . $_SERVER['REMOTE_USER'] . "\r\n";

echo "\r\n";
echo "---------------------------------------------------------------------------\r\n";
echo "\r\n";

echo "SERVER_ADDR:         " . $_SERVER['SERVER_ADDR'] . "\r\n";
echo "SERVER_NAME:         " . $_SERVER['SERVER_NAME'] . "\r\n";
echo "SERVER_SOFTWARE:     " . $_SERVER['SERVER_SOFTWARE'] . "\r\n";

echo "\r\n";
echo "---------------------------------------------------------------------------\r\n";
echo "\r\n";

echo "HTTP_X_FORWARDED_FOR:    " . $_SERVER['HTTP_X_FORWARDED_FOR'] . "\r\n";
echo "HTTP_X_FORWARDED_PROTO:  " . $_SERVER['HTTP_X_FORWARDED_PROTO'] . "\r\n";
echo "HTTP_X_REAL_IP:          " . $_SERVER['HTTP_X_REAL_IP'] . "\r\n";
echo "HTTP_CLIENT_IP:          " . $_SERVER['HTTP_CLIENT_IP'] . "\r\n";
echo "HTTP_X_REAL_IP:          " . $_SERVER['HTTP_X_REAL_IP'] . "\r\n";
echo "HTTP_CONNECTION:         " . $_SERVER['HTTP_CONNECTION'] . "\r\n";
echo "HTTP_REFERER:            " . $_SERVER['HTTP_REFERER'] . "\r\n";

echo "\r\n";
echo "---------------------------------------------------------------------------\r\n";
echo "\r\n";

?>
