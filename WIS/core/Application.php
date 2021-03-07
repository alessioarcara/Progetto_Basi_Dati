<?php
include_once('Router.php');
include_once('Request.php');
include_once('Response.php');

class Application {

  public static $ROOT_DIR;
  public $router;
  public $request;
  public $response;
  public static $app;
  public static $pdo;
  
  public function __construct($root, $pdo) 
  {
    self::$ROOT_DIR = $root."/website";
    self::$app = $this;
    $this->request = new Request();
    $this->response = new Response();
    $this->router = new Router($this->request);
    self::$pdo = $pdo;
  }

  public function run() {
    echo $this->router->resolve();
  }

}