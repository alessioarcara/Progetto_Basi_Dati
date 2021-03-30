<?php

class Router {

  protected $routes = [];
  public $request;

  public function __construct($request){
    $this->request = $request;
  }

  public function get($path, $callback) {
    //store in 'routes' the callback function of a get's path
    $this->routes['get'][$path] = $callback;
  }
  public function post($path, $callback) {
    //store in 'routes' the callback function of a post's path
    $this->routes['post'][$path] = $callback;
  }

  public function resolve() {
    //get the callback function of the specific path and method
    $path = $this->request->getPath();
    $method = $this->request->getMethod();
    $callback = $this->routes[$method][$path] ?? false;
    //if there is no callback, the response it must be 404
    if ($callback === false) {
      Application::$app->response->setStatusCode(404);
      return $this->renderContent("404 - Page not found!");
    }
    //if callback is a string, it means it's a view, so we render it
    if (is_string($callback)) {
      return $this->renderView($callback);
    }
    //if callback is an array, it means that a controller is passed as a parameter
    //so we instantiate it and save back in the callback
    if (is_array($callback)) {
      $controller = new $callback[0]();
      $callback[0] = $controller;
    }
    //finally, execute the callback 
    return call_user_func($callback, $this->request);
  }

  private function getUser() {

    $email = isset($_COOKIE['email']) ? $_COOKIE['email'] : false;
    if (!$email) {
      return false;
    }

    $sql = "SELECT * FROM UTENTE WHERE emailutente = '".$email."'";
    $result = Application::$pdo->query($sql);
    $user = $result->fetch(\PDO::FETCH_ASSOC);
    if (!$user) {return false;}

    $sql = "SELECT * FROM UTILIZZATORE WHERE emailutilizzatore = '".$email."'";
    $result = Application::$pdo->query($sql);
    $userRole = $result->fetch(\PDO::FETCH_ASSOC);
    if ($userRole) {
      $userRole['ruolo'] = 'utilizzatore';
      return array_merge( $user, $userRole);
    }

    $sql = "SELECT * FROM VOLONTARIO WHERE emailvolontario = '".$email."'";
    $result = Application::$pdo->query($sql);
    $userRole = $result->fetch(\PDO::FETCH_ASSOC);
    if ($userRole) {
      $userRole['ruolo'] = 'volontario';
      return array_merge( $user, $userRole);
    }

    $sql = "SELECT * FROM AMMINISTRATORE WHERE emailamministratore = '".$email."'";
    $result = Application::$pdo->query($sql);
    $userRole = $result->fetch(\PDO::FETCH_ASSOC);
    if ($userRole) {
      $userRole['ruolo'] = 'amministratore';
      return array_merge( $user, $userRole);
    }

    return false;
  }
  public function renderView($view, $params = []) {
    //load viewcontent and render it
    $user = $this->getUser();
    if ($user) {
      $params['user'] = $user;
    }

    $viewContent = $this->renderOnlyView($view, $params);
    return $this->renderContent($viewContent, $params);
  }

  public function renderContent($content, $params = []) {
    //render the content with the layout
    $layoutContent = $this->layoutContent('main', $params);
    return str_replace('{{content}}', $content, $layoutContent);
  }

  private function layoutContent($layout = 'main', $params = []) {
    //load the layout but block the output to the browser and instead return it
    //(it initially saves the layout in a buffer and after return it clears the buffer)
    foreach ($params as $key => $value) {
      $$key = $value;
    };
    ob_start();
    include_once Application::$ROOT_DIR."/views/layout/$layout.php";
    return ob_get_clean();
  }

  private function renderOnlyView($view, $params = []) {
    //create a variable for every parameter in params
    //these variables can be used in the views
    foreach ($params as $key => $value) {
      $$key = $value;
    };
    ob_start();
    include_once Application::$ROOT_DIR."/views/$view.php";
    return ob_get_clean();
  }
}

