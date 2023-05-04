<?php
header('Content-type: text/plain');
echo "HTTP_X_FORWARDED_FOR:    " . $_SERVER['HTTP_X_FORWARDED_FOR'] . "\r\n";
?>
