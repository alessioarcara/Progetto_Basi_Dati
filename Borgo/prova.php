<!DOCTYPE html>
<html>
<body>

<?php
  $host = "rogue.db.elephantsql.com";
  $user = "odjbcpxl";
  $pass = "nO2Qcbu_JL3IthuXaQlJh2TYUSAIJ1ef";
  $db = "ProgettoBasiDiDati";
  $port = 5432;

  // Open a PostgreSQL connection
  $con = pg_connect("host=$host dbname=$db user=$user password=$pass")
    or die ("Could not connect to server\n");

  $query = 'SELECT * FROM TEATRO';
  $results = pg_query($con, $query) or die('Query failed: ' . pg_last_error());

  $row = pg_fetch_row($results);
  echo $row[0] . "\n";
  // Closing connection
  pg_close($con);
?>

</body>
</html>