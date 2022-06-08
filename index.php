<?php
header('Content-type: text/plain');

echo "You are connected on:\r\n\r\n";
echo "HOSTNAME:       " . gethostname() . "\r\n";
echo "HOST:           " . $_SERVER['SERVER_ADDR'] . "\r\n";
echo "PORT:           " . $_SERVER['SERVER_PORT'] . "\r\n";
echo "URL:            " . $_SERVER['REQUEST_URI'] . "\r\n";
echo "HTTPS:          " . $_SERVER['HTTPS']       . "\r\n";

echo "\r\n";
echo "--------------------------------------------------\r\n";
echo "\r\n";

echo "REMOTE_ADDR:         " . $_SERVER['REMOTE_ADDR'] . "\r\n";
echo "REMOTE_PORT:         " . $_SERVER['REMOTE_PORT'] . "\r\n";
echo "REMOTE_HOST:         " . $_SERVER['REMOTE_HOST'] . "\r\n";
echo "REMOTE_USER:         " . $_SERVER['REMOTE_USER'] . "\r\n";

echo "\r\n";
echo "--------------------------------------------------\r\n";
echo "\r\n";

echo "SERVER_ADDR:         " . $_SERVER['SERVER_ADDR'] . "\r\n";
echo "SERVER_NAME:         " . $_SERVER['SERVER_NAME'] . "\r\n";
echo "SERVER_SOFTWARE:     " . $_SERVER['SERVER_SOFTWARE'] . "\r\n";

echo "\r\n";
echo "--------------------------------------------------\r\n";
echo "\r\n";

echo "HTTP_X_FORWARDED_FOR:    " . $_SERVER['HTTP_X_FORWARDED_FOR'] . "\r\n";
echo "HTTP_X_FORWARDED_PROTO:  " . $_SERVER['HTTP_X_FORWARDED_PROTO'] . "\r\n";
echo "HTTP_X_REAL_IP:          " . $_SERVER['HTTP_X_REAL_IP'] . "\r\n";
echo "HTTP_CLIENT_IP:          " . $_SERVER['HTTP_CLIENT_IP'] . "\r\n";
echo "HTTP_X_REAL_IP:          " . $_SERVER['HTTP_X_REAL_IP'] . "\r\n";
echo "HTTP_CONNECTION:         " . $_SERVER['HTTP_CONNECTION'] . "\r\n";
echo "HTTP_REFERER:            " . $_SERVER['HTTP_REFERER'] . "\r\n";

echo "\r\n";
echo "--------------------------------------------------\r\n";
echo "\r\n";

?>
