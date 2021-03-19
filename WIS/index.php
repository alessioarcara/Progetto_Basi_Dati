<?php

require_once('core/Application.php');
require_once('core/Router.php');
require_once('controllers/viewController.php');
require_once('controllers/userViewController.php');

//connect to db
$host='argonauta.synology.me';
$db = 'unibo';
$username = 'postgres';
$password = 'postgres';
$dsn = "pgsql:host=$host; port=5444; dbname=$db; user=$username; password=$password";
try{
  // create a PostgreSQL database connection
  $conn = new PDO($dsn);

  //create application //__DIR__;
  $app = new Application(dirname(__DIR__), $conn);

  //build routes
  $app->router->get('/', [viewController::class, 'home']);
  $app->router->get('/home', [viewController::class, 'home']);
  $app->router->get('/user', [userViewController::class, 'user']);
  
  $app->run();

}catch (PDOException $e){
  // report error message
  echo $e->getMessage();
  exit;
}


