<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <?php
        $host='localhost';
        $db = 'Unibo';
        $username = 'postgres';
        $password = 'Toor';

        $dsn = "pgsql:host=$host; port=5432; dbname=$db; user=$username; password=$password";

        try{
            // create a PostgreSQL database connection
            $conn = new PDO($dsn);
            
            // display a message if connected to the PostgreSQL successfully
            if($conn){
                echo "Connessione al database <strong>$db</strong> riuscita!";
            }
        }catch (PDOException $e){
            // report error message
            echo $e->getMessage();
        }
    ?>
    
</body>
</html>