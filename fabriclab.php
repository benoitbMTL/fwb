<html>
<head>
<title><?php echo "".gethostname(); ?></title>
</head>
<body>
<h1>Welcome to the FabricLab!</h1>
<h2>You are connected on:</h2>
<?php
echo "<p style=\"font-family:'Courier New'\"><b>HOSTNAME</b>: " . gethostname() . "<br>";
echo "<b>HOST</b>: " . $_SERVER['SERVER_ADDR'] . "<br>";
echo "<b>PORT</b>: " . $_SERVER['SERVER_PORT'] . "<br>";
echo "<b>URL</b>: " . $_SERVER['REQUEST_URI'] . "<br>";
echo "<b>HTTPS</b>: " . $_SERVER['HTTPS'] . "<br>";
echo "<b>SNI</b>: " . $_SERVER['SSL_TLS_SNI'] . "<br>";
echo "<b>XFF</b>: " . $_SERVER['HTTP_X_FORWARDED_FOR'] . "</p>";

echo "<h2>Links</h2>";
echo "<a href=https://" . $_SERVER['SERVER_NAME'] . "/dvwa>DVWA Web Site</a><br>";
echo "<a href=https://" . $_SERVER['SERVER_NAME'] . "/dvwa/setup.php>DVWA Database Reset</a><br>";
echo "<a href=https://" . $_SERVER['SERVER_NAME'] . "/pci.html>PCI Credit Card Number</a><br>";
echo "<a href=https://" . $_SERVER['SERVER_NAME'] . "/wso.php>Webshell Backdoor</a><br>";
echo "<a href=https://" . $_SERVER['SERVER_NAME'] . "/badsite.html>CSRF Attack</a><br>";
echo "<a href=https://" . $_SERVER['SERVER_NAME'] . "/fwb>Web Form</a><br>";

echo "<h2>HTTP Header Request</h2>";
echo "<p style=\"font-family:'Courier New'\">";
foreach (getallheaders() as $name => $value) {
    echo "<b>$name</b>: $value<br>";
}
echo "</p>";

?>
</body>
</html>
