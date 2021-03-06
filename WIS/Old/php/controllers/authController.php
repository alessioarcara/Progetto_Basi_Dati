<?php
require_once('./core/Application.php');
require_once('./controllers/viewController.php');

class authController {

  public function login($request) {
    $body = $request->getBody();

    if ($body["email"] === "" || $body["password"] === "") {
      return Application::$app->router->renderView('user');
    }

    $sql = "SELECT Authentication('".$body['email']."', '".$body['password']."')";
    $result = Application::$pdo->query($sql);
    $logged = $result->fetch(\PDO::FETCH_ASSOC)['authentication'];

    if ($logged) {
      
      setcookie('user', $body['email']);

      return header("Location: /home");
    }

    return 'Wrong email or password';
  }

  public function signup($request) {
    $body = $request->getBody();
    return $body['nickname']." grazie per l'iscrizione!" ;
  }

} 