<?php
class db
{
    protected static PDO $instance;

    protected function __construct() {}

    public static function getInstance() {
        if(empty(self::$instance)) {
            $host='argonauta.synology.me';
            $db = 'unibo';
            $username = 'postgres';
            $password = 'postgres';
            try{
                self::$instance = new PDO("pgsql:host=$host; port=5444; dbname=$db; user=$username; password=$password");
            } catch (PDOException $e){
                echo $e->getMessage();
            }
        }
        return self::$instance;
    }
}