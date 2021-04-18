<?php

require_once('core/Application.php');
require_once('core/Router.php');
require_once('controllers/viewController.php');
require_once('controllers/searchController.php');
require_once('controllers/userViewController.php');
require_once('db_conn/db.php');

//connect to db
try{
  // create a PostgreSQL database connection
  $conn = db::getInstance();

  //create application
  //create application //__DIR__;
  $app = new Application(dirname(__DIR__), $conn);

  //build routes
  $app->router->get('/', [viewController::class, 'home']);
  $app->router->get('/home', [viewController::class, 'home']);
  $app->router->get('/biblioteche', [searchController::class, 'ricerca']);
  $app->router->get('/postilettura', [searchController::class, 'ricerca']);
  $app->router->get('/libri', [searchController::class, 'ricerca']);
  $app->router->get('/user', [userViewController::class, 'user']);

  $app->run();

}catch (PDOException $e){
  // report error message
  echo $e->getMessage();
  exit;
}


