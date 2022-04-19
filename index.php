<html>
  <head>
    <meta charset="utf-8">
    <title><?php echo "".gethostname(); ?></title>
  </head>
  <body>
    <?php print "<h1>You are on ". $_SERVER['SERVER_NAME'] . "</h1>" ?>

    <p>--------------------------------------------------</p>
    <p><b>Hostname: </b><?php echo gethostname(); ?></p>
    <p><b>Address: </b><?php echo $_SERVER['SERVER_ADDR']; ?></p>
    <p><b>PHPSESSID: </b><?php echo $_COOKIE["PHPSESSID"]; ?></p>
    <p><b>Security: </b><?php echo $_COOKIE["security"]; ?></p>
    <p>--------------------------------------------------</p>

    <ul>
    <li><a href="/dvwa">dvwa</a></li>
    <li><a href="/badsite.html">badsite</a></li>
    <li><a href="/wso.php">webshell</a></li>
    <li><a href="/dvwa/hackable/uploads/">uploads</a></li>
    <li><a href="/pci.html">pci</a></li>
    </ul>

    <p>--------------------------------------------------</p>
    <?php print "REMOTE_ADDR : <b style=\"color:red;\">" . $_SERVER['REMOTE_ADDR'] . "</b>" ?>
    <p></p>
    <?php print "REMOTE_PORT : <b style=\"color:red;\">" . $_SERVER['REMOTE_PORT'] . "</b>" ?>
    <p></p>
    <?php print "REMOTE_HOST : <b style=\"color:red;\">" . $_SERVER['REMOTE_HOST'] . "</b>" ?>
    <p></p>
    <?php print "REMOTE_USER : <b style=\"color:red;\">" . $_SERVER['REMOTE_USER'] . "</b>" ?>
    <p>--------------------------------------------------</p>

    <?php print "SERVER_ADDR : <b style=\"color:red;\">" . $_SERVER['SERVER_ADDR'] . "</b>" ?>
    <p></p>
    <?php print "SERVER_NAME : <b style=\"color:red;\">" . $_SERVER['SERVER_NAME'] . "</b>" ?>
    <p></p>
    <?php print "SERVER_SOFTWARE : <b style=\"color:red;\">" . $_SERVER['SERVER_SOFTWARE'] . "</b>" ?>
    <p>--------------------------------------------------</p>

    <?php print "HTTP_X_FORWARDED_FOR : <b style=\"color:red;\">" . $_SERVER['HTTP_X_FORWARDED_FOR'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_CLIENT_IP : <b style=\"color:red;\">" . $_SERVER['HTTP_CLIENT_IP'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_X_REAL_IP : <b style=\"color:red;\">" . $_SERVER['HTTP_X_REAL_IP'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_X_FORWARDED_PROTO : <b style=\"color:red;\">" . $_SERVER['HTTP_X_FORWARDED_PROTO'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_ACCEPT : <b style=\"color:red;\">" . $_SERVER['HTTP_ACCEPT'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_CONNECTION : <b style=\"color:red;\">" . $_SERVER['HTTP_CONNECTION'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_HOST : <b style=\"color:red;\">" . $_SERVER['HTTP_HOST'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_REFERER : <b style=\"color:red;\">" . $_SERVER['HTTP_REFERER'] . "</b>" ?>
    <p></p>
    <?php print "HTTP_USER_AGENT : <b style=\"color:red;\">" . $_SERVER['HTTP_USER_AGENT'] . "</b>" ?>
    <p></p>
    <?php print "HTTPS : <b style=\"color:red;\">" . $_SERVER['HTTPS'] . "</b>" ?>
    <p>--------------------------------------------------</p>
  </body>
</html>
