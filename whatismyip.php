<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>DVWA Server (Azure)</title>
  </head>
  <body>
    <h1>You are on DVWA Server (Azure)</h1>
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
